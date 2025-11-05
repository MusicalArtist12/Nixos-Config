{ pkgs, lib, config, ... }: {
    wayland.windowManager.sway.config.output = {
        eDP-1 = {
            scale = "1.5";
            scale_filter = "linear";
            bg = "/home/julia/Pictures/Backgrounds/celeste.png fill";
            color_profile = "icc /home/julia/.config/Framework16.icm";
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
        {command = ''eww open statusbar-primary --arg monitor=eDP-1 --arg is_laptop=true --arg orientation="vertical" --arg anchor="center left" --no-daemonize'';}
    ];
    wayland.windowManager.sway.extraConfig = ''
        include ./outputs
    '';
}