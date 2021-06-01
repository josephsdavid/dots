import subprocess

def bash(cmd):
    process = subprocess.run(cmd.split())
    return process.stdout


yellow="#f3ea5f"
pink="#d8247c"
purple="#c04df9"
red="#ff3f3f"
green="#06e514"
blue='#2bd1fc'
orange="#c04df9"
normal_bg="#240e28"

def fg(color, text):
    return f"^fg({color}){text}"

def bg(color, text):
    return f"^bg({color}){text}"


def font(size):
    return f"Noto Sans Display Nerd Font-{size}"


def player_status():
    return bash("playerctl status -p spotify")

