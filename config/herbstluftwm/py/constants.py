from os import system

menupath = "/home/david/scripts/menus"
utilpath = "/home/david/scripts/utilities"

def hc(args: str):
    system(f"herbstclient {args}")
def mod(args: str) -> str:
    return f"Mod4-{args}"
def shift(args: str) -> str:
    return f"shift-{args}"
def control(args: str) -> str:
    return f"control-{args}"
def alt(args: str) -> str:
    return f"mod1-{args}"
# example: mod(shift(4))

def chain(*args, char = "."):
    to_chain = f" {char} ".join(args)
    return f"chain {char} {to_chain}"

def spawn(args):
    return f"spawn {args}"

def reload():
    return "reload"



colors = dict(
        black0 =  "#eeeeee",
        black1 =  "#bcbcbc",
        # red,
        red0 =  "#af0000",
        red1 =  "#d70000",
        # green,
        green0 =  "#008700",
        green1 =  "#d70087",
        # yellow,
        yellow0 =  "#5f8700",
        yellow1 =  "#8700af",
        # blue,
        blue0 =  "#0087af",
        blue1 =  "#d75f00",
        # magent,
        magenta0 =  "#878787",
        magenta1 =  "#d7f500",
        # cyan,
        cyan0 =  "#005f87",
        cyan1 =  "#005faf",
        # white,
        white0 =  "#444444",
        white1 =  "#008700",
        white = "fffffa"
        )

resizestep=0.05

