{ ... }:
let
  programs = (import ../programs.nix);
in
{
    programs.niri.settings.binds = {
        "Mod+D" = {
            action.spawn = [ "sh" "-c" programs.menu ];
            hotkey-overlay.title = "Open Rofi";
        };
        "Mod+Return" = {
            action.spawn = [ "kitty" ];
            hotkey-overlay.title = "Open Terminal";
        };
        "Mod+Shift+Return" = {
            action.spawn = [ "thunar" ];
            hotkey-overlay.title = "Open File Explorer";
        };

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+0".action.focus-workspace = 0;

        "Mod+Tab".action.focus-workspace-previous = [ ];

        # this has less meaning since there aren't really like gaps between workspaces
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
        "Mod+Shift+0".action.move-column-to-workspace = 0;

        "Mod+Escape" = {
            action.spawn = [ "sh" "-c" programs.menuPower ];
            hotkey-overlay.title = "Open Power Menu";
        };
        "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];
        "Mod+Shift+Q".action.close-window = [ ];

        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Right".action.focus-column-right = [ ];

        "Mod+WheelScrollUp".action.focus-column-left = [ ];
        "Mod+WheelScrollDown".action.focus-column-right = [ ];

        "Mod+Up".action.focus-window-up = [ ];
        "Mod+Down".action.focus-window-down = [ ];

        "Mod+Shift+Left".action.move-column-left = [ ];
        "Mod+Shift+Right".action.move-column-right = [ ];
        "Mod+Shift+Up".action.move-window-up = [ ];
        "Mod+Shift+Down".action.move-window-down = [ ];

        "Mod+Ctrl+Left".action.focus-monitor-left = [ ];
        "Mod+Ctrl+Right".action.focus-monitor-right = [ ];
        "Mod+Ctrl+Up".action.focus-monitor-up = [ ];
        "Mod+Ctrl+Down".action.focus-monitor-down = [ ];

        "Mod+Space".action.toggle-overview = [ ];
        "Mod+Shift+Page_Up".action.move-column-to-workspace-up = [ ];
        "Mod+Shift+Page_Down".action.move-column-to-workspace-down = [ ];

        "Mod+Page_Up".action.focus-workspace-up = [ ];
        "Mod+Page_Down".action.focus-workspace-down = [ ];

        "Mod+Shift+WheelScrollDown".action.focus-workspace-down = [ ];
        "Mod+Shift+WheelScrollUp".action.focus-workspace-up = [ ];

        "Mod+F".action.maximize-column = [ ];

        "Mod+E".action.expand-column-to-available-width = [ ]; # Expand
        "Mod+Shift+F".action.fullscreen-window = [ ]; # Fullscreen
        "Mod+B".action.toggle-window-floating = [ ]; # Balloon

        "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
        "Mod+BracketRight".action.consume-or-expel-window-right = [ ];

        "Mod+W".action.center-column = [ ];
        "Mod+T".action.toggle-column-tabbed-display = [ ];

        "Mod+Minus".action.set-window-width = "-10%";
        "Mod+Equal".action.set-window-width = "+10%";

        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+Shift+S".action.spawn = [ "sh" "-c" "${programs.screenshot}" ];

        "XF86AudioMute".action.spawn = [ "pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle" ];
        "XF86AudioRaiseVolume".action.spawn = [ "pactl" "set-sink-volume" "@DEFAULT_SINK@" "+1%" ];
        "XF86AudioLowerVolume".action.spawn = [ "pactl" "set-sink-volume" "@DEFAULT_SINK@" "-1%" ];
        "Mod+XF86AudioRaiseVolume" = {
            action.spawn = [ "sh" "-c" "python ~/.local/bin/sink_switcher.py -n" ];
            hotkey-overlay.hidden = true;
        };
        "Mod+XF86AudioLowerVolume" = {
            action.spawn = [ "sh" "-c" "python ~/.local/bin/sink_switcher.py -p" ];
            hotkey-overlay.hidden = true;
        };

        "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "s" "+10%" ];
        "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "s" "10%-" ];
    };
}
