#!/usr/bin/env bash

function get_workspaces_info() {
    output=$(niri msg -j workspaces | jq 'sort_by(.idx)')
    echo $output
}

get_workspaces_info

niri msg event-stream | {
    while read -r event; do
        get_workspaces_info
    done
}