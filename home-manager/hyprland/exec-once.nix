{ ... }:
{
    wayland.windowManager.hyprland.settings.exec-once = [
        "app2unit -- swaync"
        "app2unit -- nm-applet"
        "app2unit -- app2unit -- syshud"
        "app2unit -- wl-paste --type text --watch cliphist store"
        "app2unit -- wl-paste --type image --watch cliphist store"
        "app2unit -- eww open statusbar-primary"
        "app2unit -- thunar --daemon"
        "app2unit -- systemctl --user start tumblerd.service"
        "app2unit -- discord.desktop"
        "app2unit -- spotify.desktop"
    ];

}