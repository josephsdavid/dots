#!/usr/bin/env python3
import ast
import re
import sys
from collections import deque
from pathlib import Path


class Node(object):

    def __init__(self, node, name, doc, parent=None) -> None:
        super().__init__()
        self.name = name
        self.doc = doc
        self.parent = parent
        self.children = []
        self.node = node

    def __repr__(self):
        out = []
        out.append(
            f"parent: {self.parent.name if self.parent is not None else ''}")
        out.append(f"name: {self.name}")
        out.append(f"doc: {self.doc}")
        return "\n".join(out)

    def __hash__(self):
        return hash(self.__repr__())


class Visitor(ast.NodeVisitor):

    def __init__(self) -> None:
        super().__init__()
        self.tree = []

    def generic_visit(self, node):
        if isinstance(node,
                      (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
            name = node.name
            parent = node.parent
            if isinstance(parent, ast.Module):
                parent = None
            self.tree.append(Node(node, name, ast.get_docstring(node), parent))
        ast.NodeVisitor.generic_visit(self, node)


def set_children(tree):
    nodelist = [n.node for n in tree]
    for node in tree:
        if node.parent is not None:
            tree[nodelist.index(node.parent)].children.append(node)
    for node in tree:
        node.children = sorted(node.children, key=lambda x: tree.index(x))

    return tree


#


def make_tree(path: str):
    root = ast.parse(Path(path).read_text())
    for node in ast.walk(root):
        for child in ast.iter_child_nodes(node):
            child.parent = node
    vv = Visitor()
    vv.visit(root)
    return set_children(vv.tree)


def parse_single_doc(docstring: str, heading_level: int = 1):
    if docstring is None: return
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


def parse(tree, heading_level: int = 1, seen: set = set()):
    q = deque(tree)
    out = deque()
    while q:
        curr = q.popleft()
        if curr not in seen:
            seen.add(curr)
            out.append("*" * heading_level + " " + curr.name)
            doc = parse_single_doc(curr.doc, heading_level)
            if doc:
                out.append(doc)
            if len(curr.children) > 0:
                out.extend(parse(curr.children, heading_level + 1, seen))
    return out


def main():
    module = sys.argv[1]
    ret = "\n".join(parse(make_tree(module)))
    return ret


if __name__ == "__main__":
    print(main())
