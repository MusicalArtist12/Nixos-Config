{ pkgs, ... }:
let
    theme = (import ../theme.nix);
    accent = theme.mauve_hex;
in
{
    imports = [
        ../hyprlock
        ../swayidle
    ];

    programs.niri.settings = {
        spawn-at-startup = [
            { sh = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"; }
            { sh = "systemctl --user start eww-daemon.service"; }
            { sh = "swaybg -m fill -i /home/julia/Pictures/Backgrounds/celeste.png"; }
            { sh = "app2unit -- syshud"; }
            { sh = "${pkgs.hyprlock}/bin/hyprlock --immediate-render"; } # autologin
        ];
        outputs = {
            "Acer Technologies XZ342CK TKNAA0013900" = {
                mode = {
                    refresh = 144.0;
                    width = 3440;
                    height = 1440;
                };
            };
            "BOE 0x0BC9 Unknown" = {
                scale = 1.0;
                variable-refresh-rate = true;
            };
        };
        input = {
            touchpad.natural-scroll = false;
            touchpad.click-method = "clickfinger";
            touchpad.dwt = true;
            mouse.accel-profile = "flat";
            keyboard.numlock = true;
        };

        layout = {
            gaps = 10;
            # center-focused-column = "on-overflow";
            always-center-single-column = true;
            tab-indicator = {
                width = 8;
                active = {
                    color = accent;
                };
                inactive = {
                    color = theme.overlay0_hex;
                };
                urgent = {
                    color = theme.red_hex;
                };
            };
            # empty-workspace-above-first = true;
            focus-ring = {
                enable = true;
                width = 2;
                active = {
                    color = accent;
                };
                inactive = null;
                urgent = {
                    color = theme.red_hex;
                };
            };
            insert-hint = {
                enable = true;
                display = {
                    color = accent;
                };
            };
        };

        gestures.hot-corners.enable = false; # until i can change the corner
        prefer-no-csd = true;
        clipboard.disable-primary = true;

        window-rules = [
            {
                matches = [ ];
                geometry-corner-radius = {
                    bottom-left = 10.0;
                    bottom-right = 10.0;
                    top-left = 10.0;
                    top-right = 10.0;
                };
                clip-to-geometry = true;
            }
            {
                matches = [ { title = "^notificationtoasts_\d+_desktop$"; app-id = "steam"; } ];
                default-floating-position = {
                    x = 10;
                    y = 10;
                    relative-to = "bottom-right";
                };
                open-floating = true;
                open-focused = false;
            }
            {
                matches = [ { app-id = "steam"; } ];
                excludes = [ { title = "^[Ss]team$"; } ];
                open-floating = true;
            }
        ];
    };


    home.packages = with pkgs; [
        xwayland-satellite # xwayland support
        swaybg
        syshud
    ];

}
