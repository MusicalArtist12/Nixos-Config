#!/usr/bin/env python

import os
import re
import sys
import json

class App:
    def __init__(self, id, pid, app_id, name) -> None:
        self.id = id
        self.pid = pid
        self.app_id = app_id
        self.name = name

    def __repr__(self) -> str:
        return f"id: {self.id} pid: {self.pid} class: '{self.app_id}' name: '{self.name}'"

def parse_nodes(node, depth):
    children = node["nodes"]

    lst: list[App] = []
    for child in children:
        # print(f"{''.join(['  ' for i in range(depth)])}id: {child["id"]} pid: {child.get("pid", "n/a")} app_id: '{child.get("app_id", "")}' name: '{child["name"]}'")

        if child.get("pid", "") != "":
            lst.append(App(child["id"], child["pid"], child["app_id"], child["name"]))

        lst = lst + parse_nodes(child, depth + 1)


    return lst

def get_tree():
    with os.popen("/usr/bin/env swaymsg -t get_tree") as stdin:
        tree = json.load(stdin)
        # print(len(tree))
        return parse_nodes(tree, 0)

lst = get_tree()

if len(sys.argv) > 1:
    if sys.argv[1] == "kill" and len(sys.argv) > 2:
        processes = [x for x in lst if x.app_id == sys.argv[2]]
        for process in processes:
            os.popen(f"kill {process.pid}")
    elif sys.argv[1] == "list":
        for app in lst:
            print(app)
    else:
        print("unknown command, use 'kill <class>', or 'list'")
else:
    for app in lst:
        print(app)