import socket
import os
import json
import sys


# where workspaces is a list of active workspaces on this monitor
# and active_workspace points to an item on workspaces. -1 if no active workspace on monitor


def get_path():
    instance_sig = os.environ['HYPRLAND_INSTANCE_SIGNATURE']
    xdg_runtime_dir = os.environ['XDG_RUNTIME_DIR']

    path = f'{xdg_runtime_dir}/hypr/{instance_sig}'

    return path

def open_sock1():
    sock1 = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock1.connect(f'{get_path()}/.socket.sock')

    return sock1

def open_sock2():
    sock2 = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock2.connect(f'{get_path()}/.socket2.sock')

    return sock2


class HyprlandWorkspaceListener:

    def get_monitors(self):
        sock = open_sock1()
        sock.send(b'-j/monitors')

        data = ""
        while True:
            recv = sock.recv(256)
            if len(recv) == 0:
                break

            data += recv.decode()
        sock.close()

        self.workspaces: dict[str, str] = {}
        self.active_special: dict[str, str] = {}
        data = json.loads(data)

        for x in data:
            self.workspaces[x['name']] = []
            self.active_special[x['name']] = ""

    def get_workspaces(self):

        sock = open_sock1()
        sock.send(b'-j/workspaces')

        data = ""
        while True:
            recv = sock.recv(256)
            if len(recv) == 0:
                break

            data += recv.decode()
        sock.close()

        data = json.loads(data)

        self.special_workspaces = []

        for workspace in data:
            if workspace['name'].startswith(('special', "Special")):
                self.special_workspaces.append(workspace['name'])
            else:
                self.workspaces[workspace['monitor']].append(workspace['name'])


    def get_active_workspace(self):
        sock = open_sock1()
        sock.send(b'-j/activeworkspace')


        data = ""
        while True:
            recv = sock.recv(256)
            if len(recv) == 0:
                break

            data += recv.decode()
        sock.close()
        data = json.loads(data)

        self.active_monitor = data['monitor']
        self.active_workspace = data['name']

    def __str__(self):
        for key in self.workspaces.keys():
            self.workspaces[key].sort()

        return json.dumps({
            "workspaces": self.workspaces,
            "special_workspaces": self.special_workspaces,
            "active_monitor": self.active_monitor,
            "active_workspace": self.active_workspace,
            "active_special": self.active_special
        })

    def __init__(self):
        self.get_monitors()
        self.get_workspaces()
        self.get_active_workspace()

        print(self)

    def set_workspace(self, workspace):
        if workspace not in self.workspaces[self.active_monitor]:
            for key in self.workspaces.keys():
                if workspace in self.workspaces[key]:
                    self.workspaces[key].remove(workspace)
                    break
            self.workspaces[self.active_monitor].append(workspace)

        self.active_workspace = workspace



    def handle(self, raw: str):
        events = raw.split('\n')
        for event in events:

            # print(event)
            split = event.split('>>')


            name = split[0]

            if len(split) > 1:
                data = split[1].split(',')

            match name:
                case 'workspace':
                    self.set_workspace(data[0])


                case 'focusedmon':
                    self.active_monitor = data[0]

                    self.set_workspace(data[1])

                case 'monitorremoved':
                    self.workspaces.pop(data[1])
                case 'monitoradded':
                    self.workpaces.append(data[1])
                case 'createworkspace':
                    if data[0] not in self.workspaces[self.active_monitor]:
                        if data[0].startswith(('special', "Special")):
                            self.special_workspaces.append(data[0])
                        else:
                            self.workspaces[self.active_monitor].append(data[0])

                case 'destroyworkspace':
                    if data[0] in self.workspaces[self.active_monitor]:
                        self.workspaces[self.active_monitor] = [i for i in self.workspaces[self.active_monitor] if not i == data[0]]

                    elif data[0].startswith(('special', "Special")):
                        self.special_workspaces = [i for i in self.special_workspaces if not i == data[0]]

                case 'activespecial':
                    self.active_special[data[1]] = data[0]

    def listen(self):
        sock = open_sock2()

        while True:
            print(f'{self}')
            sys.stdout.flush()
            recv = sock.recv(256)
            if len(recv) == 0:
                break

            self.handle(recv.decode())


if __name__ == '__main__':
    listener = HyprlandWorkspaceListener()
    listener.listen()