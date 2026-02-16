# swaymsg -t get_outputs | jq  -r
# returns a json array of screen objects
# lowest ID i believe means primary
    # could also go with position = 0,0

# based on rect.width and rect.height (post-rotation) determine bar location
# since its meant to be on the narrow edge of the screen
# left and bottom (arbitrary)

# need to find a way to refresh when a display is plugged in
# because looping would be inefficient
# could connect to the sway ipc
# could connect to a process signal and the reload key
# maybe systemd?

import json
import os
import sys
from typing import Any


def openStatusbarFromAllDisplays(wm: str, primaryMonitor: str, isLaptop: bool = False):

    if wm == "sway":
        os.popen("systemctl --user restart eww-daemon.service")
        displays = json.load(os.popen("/usr/bin/env swaymsg -t get_outputs | jq  -r"))

        def sortDisplaysByID(x):
            return x["id"]

        displays.sort(key=sortDisplaysByID)
        for display in displays:
            width = int(display["rect"]["width"])
            height = int(display["rect"]["height"])
            name = display["name"]
            # print(f'{display["id"]}, {name}, {width}x{height}')

            orientation = "h"
            anchor = "center bottom"

            if width > height:
                orientation = "v"
                anchor = "center left"

            if name == primaryMonitor:
                os.popen(f'eww open statusbar-primary --arg monitor={name} --arg is_laptop={"true" if isLaptop else "false"} --arg orientation="{orientation}" --arg anchor="{anchor}" --no-daemonize').read()
            else:
                os.popen(f'eww open statusbar-secondary --id {name} --arg monitor={name}  --arg orientation="{orientation}" --arg anchor="{anchor}" --no-daemonize').read()

    elif wm == "niri":
        displays: dict[str, Any] = json.load(os.popen("/usr/bin/env niri msg -j outputs | jq -r "))

        for key in displays.keys():
            display = displays[key]

            width = display["logical"]["width"]
            height = display["logical"]["height"]
            name = key

            orientation = "h"
            anchor = "center bottom"

            if width > height:
                orientation = "v"
                anchor = "center left"

            if name == primaryMonitor:
                os.popen(f'eww open statusbar-primary --arg monitor={name} --arg is_laptop={"true" if isLaptop else "false"} --arg orientation="{orientation}" --arg anchor="{anchor}" --no-daemonize').read()
            else:
                os.popen(f'eww open statusbar-secondary --id {name} --arg monitor={name}  --arg orientation="{orientation}" --arg anchor="{anchor}" --no-daemonize').read()

def main():
    isLaptop = False
    primaryMonitor = ""
    wm = "sway"

    for arg in sys.argv[1::]:
        if '=' in arg:
            [key, val] = arg.split("=")
            if key == "--primary":
                primaryMonitor = val
            if key == "--wm":
                wm = val
        else:
            if arg == "-h":
                print("--primary=display")
                print("--wm=wm")
                print("--laptop")
                exit()

            if arg == "--laptop":
                isLaptop = True

    openStatusbarFromAllDisplays(wm, primaryMonitor, isLaptop)

if __name__ == "__main__":
    main()