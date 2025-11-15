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


def openStatusbarFromAllDisplays(isLaptop: bool = False):
    os.popen("systemctl --user restart eww-daemon.service")
    displays = json.load(os.popen("/usr/bin/env swaymsg -t get_outputs | jq  -r"))

    def sortDisplaysByID(x):
        return x["id"]
    displays.sort(key=sortDisplaysByID)

    first = True
    for display in displays:
        width = int(display["rect"]["width"])
        height = int(display["rect"]["height"])
        name = display["name"]
        # print(f'{display["id"]}, {name}, {width}x{height}')

        orientation = "horizontal"
        anchor = "center bottom"


        if width > height:
            orientation = "vertical"
            anchor = "center left"

        if first:
            os.popen(f'eww open statusbar-primary --arg monitor={name} --arg is_laptop={isLaptop} --arg orientation="{orientation}" --arg anchor="{anchor}" --no-daemonize').read()
        else:
            os.popen(f'eww open statusbar-secondary --arg monitor={name}  --arg orientation="{orientation}" --arg anchor="{anchor}" --no-daemonize').read()
        if first:
            first = False

def main():
    isLaptop = False

    for arg in sys.argv[1::]:
        if arg == "--laptop":
            isLaptop = True

    openStatusbarFromAllDisplays(isLaptop)

if __name__ == "__main__":
    main()