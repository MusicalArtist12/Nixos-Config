
import os
import re
import sys

def get_sinks():
    default_sink = os.popen("/usr/bin/env pactl get-default-sink").read().strip("\n")

    default_index = -1
    with os.popen("/usr/bin/env pamixer --list-sinks") as stdin:
        sinks = []
        for idx, line in enumerate(stdin):
            match = re.search(r'(?:["])(alsa_output.+?)(?:["])', line)
            if match is not None:
                index = re.search(r'^([0-9]+)', line)
                display = re.search(r'(?:")([A-Za-z0-9\ \(\)\/]+)(?:")$', line)

                if match.group(1) == default_sink:
                    default_index = idx

                sinks.append((index.group(0), match.group(1), display.group(1), match.group(1) == default_sink))

        def sort_by_index(e):
            (index, alsa, display, default) = e
            return index

        sinks.sort(key = sort_by_index)

        return (sinks, default_index)

def decrement():
    (sinks, default_index) = get_sinks()

    default_index = (len(sinks) + default_index - 1) % len(sinks)

    os.popen(f'notify-send "switching to {sinks[default_index][2]}"').read()
    os.popen(f"/usr/bin/env pactl set-default-sink {sinks[default_index][1]}").read()

def increment():
    (sinks, default_index) = get_sinks()

    default_index = (len(sinks) + default_index + 1) % len(sinks)

    os.popen(f'notify-send "switching to {sinks[default_index][2]}"').read()
    os.popen(f"/usr/bin/env pactl set-default-sink {sinks[default_index][1]}").read()

def main():
    for arg in sys.argv[1::]:
        if arg == "-n" or arg == "--next":
            increment()
        elif arg == "-p" or arg == "--prev":
            decrement()


if __name__ == "__main__":
    main()