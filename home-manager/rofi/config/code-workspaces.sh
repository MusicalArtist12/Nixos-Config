#!/usr/bin/env bash

if [ -z "$1" ]; then
    ls /home/$USERNAME/code-workspaces
else
    code /home/$USERNAME/code-workspaces/$1
fi