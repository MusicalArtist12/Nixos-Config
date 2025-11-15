{ pkgs, lib, config, ... }: {
    wayland.windowManager.sway.config.output = {
        DP-3 = {
            bg = "/home/julia/Pictures/Backgrounds/celeste.png fill";
        };
        DP-2 = {
            bg = "/home/julia/Pictures/Backgrounds/celeste.png fill";
        };
    };
    wayland.windowManager.sway.config.startup = [
        {command = "app2unit -- coolercontrol";}
        {command = "/usr/bin/env python ~/.local/bin/auto_statusbar.py"; always = true;}
    ];
    wayland.windowManager.sway.extraConfig = ''
        include ./outputs
        workspace 1 output DP-1
        workspace 2 output DP-1
        workspace 3 output DP-1
        workspace 4 output DP-1
        workspace 5 output DP-1
        workspace 6 output DP-2
        workspace 7 output DP-2
        workspace 8 output DP-2
        workspace 9 output DP-2
        workspace 10 output DP-2

        for_window [class="Spotify"] move window to workspace 10
    '';
}