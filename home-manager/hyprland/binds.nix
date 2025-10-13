{ ... }:
let
    programs = (import ./variables.nix);
in {

    wayland.windowManager.hyprland.settings = {
        "$mainMod" = "SUPER";

        bind = [
            "$mainMod Shift, Q, killactive,"
            "$mainMod Alt, Q, exec, forcekillactive"
            "$mainMod SHIFT, F, togglefloating"
            "$mainMod, F, fullscreen"
            "$mainMod, Space, exec, swaync-client -t"
            "$mainMod SHIFT, P, togglefloating"
            "$mainMod SHIFT, P, pin"
            "$mainMod Shift, L, exec, loginctl lock-session"
            "$mainMod Shift, R, exec, hyprctl reload"
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"
            "$mainMod Shift, left, movewindow, l"
            "$mainMod Shift, right,movewindow, r"
            "$mainMod Shift, up, movewindow, u"
            "$mainMod Shift, down,movewindow, d"
            "$mainMod, G, togglegroup"
            "$mainMod Shift, left, changegroupactive, f"
            "$mainMod Shift, right, changegroupactive, b"
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"
            "$mainMod Shift, 1, movetoworkspace, 1"
            "$mainMod Shift, 2, movetoworkspace, 2"
            "$mainMod Shift, 3, movetoworkspace, 3"
            "$mainMod Shift, 4, movetoworkspace, 4"
            "$mainMod Shift, 5, movetoworkspace, 5"
            "$mainMod Shift, 6, movetoworkspace, 6"
            "$mainMod Shift, 7, movetoworkspace, 7"
            "$mainMod Shift, 8, movetoworkspace, 8"
            "$mainMod Shift, 9, movetoworkspace, 9"
            "$mainMod Shift, 0, movetoworkspace, 10"
            "$mainMod, TAB, togglespecialworkspace, Discord"
            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"

            "$mainMod Shift, S, exec, [float;noanim] app2unit -- ${programs.screenshot}"
            "$mainMod Shift, RETURN, exec, app2unit -- ${programs.fileManager}"
            "$mainMod, Return, exec, app2unit -- ${programs.terminal}"
            "$mainMod, D, exec, app2unit -- ${programs.menu}"
            "$mainMod, C, exec, app2unit -- ${programs.clipboard}"
            "$mainMod, P, exec, app2unit -- ${programs.python_term}"
            ",Print, exec, ${programs.screenshot_window}"

            "$mainMod, KP_Up, layoutmsg, orientationtop"
            "$mainMod, KP_8, layoutmsg, orientationtop"
            "$mainMod, KP_Down, layoutmsg, orientationbottom"
            "$mainMod, KP_2, layoutmsg, orientationbottom"
            "$mainMod, KP_Left, layoutmsg, orientationleft"
            "$mainMod, KP_4, layoutmsg, orientationleft"
            "$mainMod, KP_Right, layoutmsg, orientationright"
            "$mainMod, KP_6, layoutmsg, orientationright"
            "$mainMod, KP_Begin, layoutmsg, orientationcenter"
            "$mainMod, KP_5, layoutmsg, orientationcenter"
            "$mainMod, KP_Enter, layoutmsg, swapwithmaster"
        ];

        bindm = [
            "$mainMod, E, movewindow"
            "$mainMod, R, resizewindow"
        ];
        bindle = [
            ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
            ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
            ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
            ",XF86MonBrightnessUp, exec, brightnessctl s +5%"
            ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ];
    };
}