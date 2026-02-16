#!/usr/bin/env python

import os
import re
import sys

def get_sinks():
    default_sink = os.popen("/usr/bin/env pactl get-default-sink").read().strip("\n")

    with os.popen("/usr/bin/env pamixer --list-sinks") as stdin:
        sinks = []
        for idx, line in enumerate(stdin):
            match = re.search(r'(?:["])((alsa|bluez)_output.+?)(?:["])', line)

            if match is not None:
                index = re.search(r'^([0-9]+)', line)
                display = re.search(r'(?:")([A-Za-z0-9\-\ \(\)\/]+)(?:")$', line)

                if match.group(1) == default_sink:
                    default_index = idx

                sinks.append((index.group(0), match.group(1), display.group(1), match.group(1) == default_sink))

        def sort_by_index(e):
            (index, alsa, display, default) = e
            return index

        sinks.sort(key = sort_by_index)

        return sinks

def decrement():
    sinks = get_sinks()

    index = [i for i, item in enumerate(sinks) if item[3]][0]

    index = (index + 1) % len(sinks)

    os.popen(f'notify-send "switching to {sinks[index][2]}"').read()
    os.popen(f"/usr/bin/env pactl set-default-sink {sinks[index][1]}").read()

def increment():
    sinks = get_sinks()

    index = [i for i, item in enumerate(sinks) if item[3]][0]

    index = (index - 1) % len(sinks)


    os.popen(f'notify-send "switching to {sinks[index][2]}"').read()
    os.popen(f"/usr/bin/env pactl set-default-sink {sinks[index][1]}").read()

def nerdfont():
    sinks = get_sinks()

    index = [i for i, item in enumerate(sinks) if item[3]][0]

    default = sinks[index][2]
    default_alsa = sinks[index][1]

    if re.search(r"HDMI", default):
        print("󰽟")
    elif re.search(r"Headset", default):
        print("󰋎")
    elif re.search("Expansion Card", default) or (re.search(r"\(IEC958\)", default)):
        print("󱡬")
    elif re.search("Analog Stereo", default):
        print("󰓃")
    elif re.search("bluez_output", default_alsa):
        print("󰂯")
    else:
        print("")

def main():
    for arg in sys.argv[1::]:
        if arg == "-n" or arg == "--next":
            increment()
        elif arg == "-p" or arg == "--prev":
            decrement()
        elif arg == "--icon":
            nerdfont()

if __name__ == "__main__":
    main()