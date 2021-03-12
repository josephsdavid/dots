from constants import mod, shift, control, alt, menupath, utilpath, spawn, chain, reload

def rotate(n):
    assert n > 0
    return chain("lock", *["rotate" for _ in range(n)], "unlock")


keybinds = {
        mod("slash") : spawn(f"{menupath}/system-menu.sh"),
        mod(shift("q")) : spawn(f"{menupath}/locker.sh"),
        mod(shift("r")) :reload(),
        # rotations
        mod("y") : rotate(3),
        mod(alt("y")) : rotate(2),
        mod(shift("y")) : rotate(1),
        # close windows
        mod("x"): "close",
        mod("w") : "remove",
        mod(shift("c")): "close_or_remove",
        # spawn things
        mod("d"): spawn("rofi -show drun"),
        mod(shift("Return")): spawn("rofi  -show Files -modi Files:/home/david/scripts/utilities/rofi-file-browser"),
        mod("Return"): spawn("termite"),
        mod(shift("v")): spawn("firefox"),
        "XF86AudioRaiseVolume": spawn(f"{utilpath}/vol up"),
        "XF86AudioLowerVolume": spawn(f"{utilpath}/vol down"),
        "XF86AudioMute": spawn(f"{utilpath}/vol mute"),
        "XF86MonBrightnessUp": spawn(f"{utilpath}/bright up"),
        mod(alt("Down")): spawn("playerctl play-pause"),
        "XF86AudioPlay": spawn("playerctl play-pause"),
        mod(alt("Left")) :spawn("playerctl previous"),
        "XF86AudioPrev": spawn("playerctl previous"),
        "XF86AudioNext": spawn("playerctl next"),
        mod(alt("Right")): spawn("playerctl next"),
        }

