{ ... }:
let
    theme = (import ../theme.nix);
    accent = theme.mauve;
in
{
    imports = [
        ./binds.nix
        ./exec-once.nix
        ./hyprlock.nix
        ./hypridle.nix
        ./hyprpaper.nix
    ];

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
        #nwg-display
        source = "~/.config/hypr/monitors.conf";
        env = [
            "XDG_CURRENT_DESKTOP, Hyprland"
            "XDG_SESSION_TYPE, wayland"
            "XDG_SESSION_DESKTOP, Hyprland"
            "ELECTRON_OZONE_PLATFORM_HINT, wayland"
            "QT_QPA_PLATFORM, wayland;xcb"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "QT_QPA_PLATFORMTHEME,qt6ct"
            "QT_AUTO_SCREEN_SCALE_FACTOR, 0"
            "QT_ENABLE_HIGHDPI_SCALING, 0"
            "MOZ_ENABLE_WAYLAND, 1"
            "ADW_DISABLE_PORTAL, 1"
            "GDK_SCALE,1"
            "GDK_BACKEND,wayland,x11,*"
            "SDL_VIDEODRIVER,wayland"
            "XCURSOR_SIZE,32"
            "HYPRCURSOR_SIZE,32"
            "EDITOR,vim"
            "PAGER,less"
        ];
        windowrulev2 = [
            "workspace special:Discord silent, class:(discord)"
            "workspace special:Discord silent, class:(vesktop)"
            "workspace special:Discord silent, title:(.*Spotify.*)"
            "float, class:(nm-connection-editor)"
            "noinitialfocus, class:(flameshot)"
            "float, class:(Bitwarden)"
            "float, class:(org.pulseaudio.pavucontrol)"
            "float, title:(File Operation Progress)"
            "size 1200 800, class:(org.pulseaudio.pavucontrol)"
        ];

        xwayland = {
            force_zero_scaling = true;
        };
        general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            "col.active_border" = accent;
            "col.inactive_border" = theme.surface0;
            layout = "dwindle";
            allow_tearing = true;
        };
        decoration = {
            rounding = 10;
        };
        ecosystem = {
            no_donation_nag = true;
            no_update_news = false;
        };
        animations = {
            enabled = true;
            bezier = [
                "pop, 0.455, 0.03, 0.515, 0.955"
                "window, 0.445, 0.05, 0.55, 0.95"
                "color, 0.5, 0.03, 0.5, 0.95"
            ];
            animation = [
                "windows, 1, 3, window, slide"
                "border, 1, 2, color"
                "borderangle, 1, 8, default, once"
                "workspaces, 1, 4, pop, slide"
                "specialWorkspace, 1, 5, pop, slidevert"
                "layers, 1, 5, pop, slide down"
            ];
        };
        misc = {
            force_default_wallpaper = false;
            disable_splash_rendering = false;
            vfr = true;
            vrr = 1;

        };

    };
}