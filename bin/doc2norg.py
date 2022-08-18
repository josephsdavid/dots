#!/usr/bin/env python3
import inspect
import re
import sys
from collections import deque
from typing import Any, List, Optional
import os
import sys

# TODO Some sort of path magic, for example os.cwd/path/to/module, or something, never written a script like this
sys.path.append(os.getcwd())

print(os.getcwd())

class Doc(object):

    def __init__(self, name: str, doc: str, parent: Optional["Doc"] = None):
        """

        Parameters
        ----------
        name: str

        doc: str

        parent: Optional["Doc"] = None

        """
        self.parent = parent
        self.name = name
        self.doc = doc
        self.children = []

    def __repr__(self):
        out = []
        out.append(
            f"parent:{self.parent.name if self.parent is not None else ''}")
        out.append(f"name:{self.name}")
        out.append(f"doc:{self.doc}")
        return "\n".join(out)

    def __hash__(self):
        return hash((self.name, self.doc))


def is_relevant(obj: Any) -> bool:
    """
    Filter for the inspector to filter out non user defined functions/classes

    Parameters
    --------
    obj: Any


    Returns
    -------
    out: bool

    """
    if hasattr(obj, '__name__') and obj.__name__ == 'type':
        out = False
    elif inspect.isfunction(obj) or inspect.isclass(obj) or inspect.ismethod(
            obj):
        out = True
    else:
        out = False
    return out


def get_docs(module: Any) -> List[Doc]:
    default = 'No doc string provided'  # Default if there is no docstring, can be removed if you want

    initial = Doc(*(module.__name__, module.__doc__))
    if initial.doc == None:
        initial.doc = ''
    doclist = [initial]

    for child in inspect.getmembers(module, is_relevant):
        doc = inspect.getdoc(child[1])
        if not doc:
            doc = default
        doclist.append(Doc(*(child[0], doc), parent=doclist[0]))
        idx = doclist.index(doclist[-1])

        if inspect.isclass(child[1]):
            for grandchild in inspect.getmembers(child[1], is_relevant):
                doc = inspect.getdoc(grandchild[1])
                if not doc:
                    doc = default
                doclist.append(Doc(*(grandchild[0], doc), parent=doclist[idx]))
    doclist = sorted(list(set(doclist)), key=lambda x: doclist.index(x))
    return doclist


def set_children(docs: List[Doc]) -> List[Doc]:
    for d in docs:
        if d.parent is not None:
            docs[docs.index(d.parent)].children.append(d)
    for d in docs:
        d.children = sorted(d.children, key=lambda x: docs.index(x))

    return docs


def parse_single_doc(docstring: str, heading_level: int = 1):
    q = deque(docstring.splitlines())
    dash = re.compile("^-")
    out = deque()
    items = False
    while q:
        curr = q.popleft()
        if len(curr.strip()) == 0:
            continue
        if "---" in curr or "===" in curr:
            out[-1] = "*" * (heading_level + 1) + " " + re.sub(
                dash, "", out[-1].strip()).strip()
            items = True
            continue
        if items:
            out.append("  " * (heading_level + 1) + "- " + curr)
            continue
        out.append("  " * (heading_level + 1) + curr)
    return "\n".join(out)


def parse(docs: List[Doc], heading_level: int = 1, seen: set = set()):
    q = deque(docs)
    out = deque()
    while q:
        curr = q.popleft()
        if curr not in seen:
            seen.add(curr)
            out.append("*" * heading_level + " " + curr.name)
            out.append(parse_single_doc(curr.doc, heading_level))
            if len(curr.children) > 0:
                out.extend(parse(curr.children, heading_level + 1, seen))
    return out


def main():
    module = __import__(sys.argv[1])
    ret = "\n".join(parse(set_children(get_docs(module))))
    return ret


if __name__ == "__main__":
    print(main())
