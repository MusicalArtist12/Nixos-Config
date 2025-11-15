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


def openStatusbarFromAllDisplays(primaryMonitor, isLaptop: bool = False):
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

def main():
    isLaptop = False
    primaryMonitor = ""

    for arg in sys.argv[1::]:
        [key, val] = arg.split("=")

        if key == "--laptop":
            isLaptop = True
        elif key == "--primary":
            primaryMonitor = val

    openStatusbarFromAllDisplays(primaryMonitor, isLaptop)

if __name__ == "__main__":
    main()