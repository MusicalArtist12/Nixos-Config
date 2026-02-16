{ pkgs, lib, config, ... }: {
    wayland.windowManager.sway.config.output = {
        "*" = {
            bg = "/home/julia/Pictures/Backgrounds/celeste.png fill";
        };
    };
    wayland.windowManager.sway.config.startup = [
        {command = "app2unit -- coolercontrol";}
        {command = "/usr/bin/env python ~/.local/bin/auto_statusbar.py --primary=DP-3"; always = true;}
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

        input 1133:16511:Logitech_G502 scroll_factor 0.5

        for_window [class="Spotify"] move window to workspace 10
    '';

    # For Monado:
    xdg.configFile."openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";


    xdg.configFile."openvr/openvrpaths.vrpath".text = ''
    {
        "config" :
        [
            "${config.xdg.dataHome}/Steam/config"
        ],
        "external_drivers" : null,
        "jsonid" : "vrpathreg",
        "log" :
        [
            "${config.xdg.dataHome}/Steam/logs"
        ],
        "runtime" :
        [
            "${pkgs.opencomposite}/lib/opencomposite"
        ],
        "version" : 1
    }
    '';

    programs.niri.settings.spawn-at-startup = [
        { sh = "/usr/bin/env python ~/.local/bin/auto_statusbar.py --primary=DP-3 --wm=niri"; }
    ];

}