#!/usr/bin/env bash

# Julia Abdel-Monem - github.com/MusicalArtist12

sleep 1

RESULT=$(hyprpicker -n)

magick -size 100x100 xc:$RESULT $HOME/.cache/hyprpicker-extended/output.png

notify-send $RESULT -i $HOME/.cache/hyprpicker-extended/output.png

echo $RESULT | wl-copy
