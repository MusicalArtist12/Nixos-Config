{ pkgs, lib, config, ... }: {
    wayland.windowManager.sway.config.output = {
        eDP-1 = {
            bg = "/home/julia/Pictures/Backgrounds/celeste.png fill";
            color_profile = "icc /home/julia/.config/Framework16.icm";
        };
    };
    wayland.windowManager.sway.config.startup = [
        {command = "/usr/bin/env python ~/.local/bin/auto_statusbar.py --laptop --primary=eDP-1"; always = true;}
    ];
    wayland.windowManager.sway.config.input = {
        "type:keyboard" = {
            xkb_layout = "us";
            xkb_variant = "altgr-intl";
        };
    };
    wayland.windowManager.sway.extraConfig = ''
        include ./outputs
        bindswitch lid:on exec systemctl sleep

        for_window [class="Spotify"] move window to workspace 10
    '';

    # services.swayidle.timeouts = [
	#     { timeout = 60; command = "if pgrep hyprlock; then systemctl sleep; fi"; }
	# ];
}