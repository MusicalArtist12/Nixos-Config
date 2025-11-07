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
        {command = "app2unit -- syshud";}
        {command = "app2unit -- discord.desktop";}
        {command = "app2unit -- spotify.desktop";}
        {command = "app2unit -- nm-applet";}
        {command = "app2unit -- wl-paste --type text --watch cliphist store";}
        {command = "app2unit -- wl-paste --type image --watch cliphist store";}
        {command = "app2unit -- thunar --daemon";}
        {command = "systemctl --user start tumblerd.service";}
        {command = "systemctl --user start eww-daemon.service";}
        {command = "app2unit -- coolercontrol";}
        {command = ''eww open statusbar-primary --arg monitor=DP-3 --arg is_laptop=false --arg orientation="vertical" --arg anchor="center left" --no-daemonize'';}
        {command = ''eww open statusbar-secondary --arg monitor=DP-2 --arg orientation="horizontal" --arg anchor="center bottom" --no-daemonize'';}
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