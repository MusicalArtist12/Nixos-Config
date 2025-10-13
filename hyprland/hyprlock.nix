{ ... }:
let
    theme = (import ./theme.nix);
    accent = theme.mauve;
in
{
    programs.hyprlock = {
        enable = true;
        settings = {
            general = {
                hide_cursor = true;
            };
            background = {
                color = theme.base;
                path = "color";
            };
            animations.enabled = false;
            input-field = [
                {
                    size = "200, 50";
                    outline_thickness = 3;
                    dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
                    dots_spacing = 0.15; # Scale of dots' absolute size, -1.0 - 1.0
                    dots_center = false;
                    dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
                    dots_fade_time = 200; # Milliseconds until a dot fully fades in
                    outer_color = accent;
                    inner_color = theme.crust;
                    font_color = theme.text;
                    font_family = "Noto Sans"; # Font used for placeholder_text, fail_text and dots_text_format.
                    fade_on_empty = false;
                    fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
                    placeholder_text = "<i>Input password...</i>"; # Text rendered in the input box when it's empty.
                    hide_input = false;
                    rounding = -1; # -1 means complete rounding (circle/oval)
                    check_color = theme.yellow;
                    fail_color = theme.red; # if authentication failed, changes outer_color and fail message color
                    fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
                    fail_timeout = 2000; # milliseconds before fail_text and fail_color disappears
                    fail_transition = 300; # transition time in ms between normal outer_color and fail_color
                    capslock_color = theme.red;
                    numlock_color = theme.red;
                    bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
                    invert_numlock = false; # change color if numlock is off
                    swap_font_color = false; # see below

                    position = "0, -20";
                    halign = "center";
                    valign = "center";
                }
            ];
            label = [
                {
                    text = "Hello $USER";
                    text-align = "center";
                    color = theme.text;
                    font_size = 40;
                    font_family = "Noto Sans";
                    rotate = 0; # degrees, counter-clockwise

                    position = "0, 140";
                    halign = "center";
                    valign = "center";
                }
                {
                    text = "$TIME";
                    text_align = "center"; # center/right or any value for default left. multi-line text alignment inside label container
                    color = theme.text;
                    font_size = 40;
                    font_family = "Noto Sans";
                    rotate = 0; # degrees, counter-clockwise

                    position = "0, 60";
                    halign = "center";
                    valign = "center";
                }
                {
                    text = "$FPRINTPROMPT";
                    color = theme.text;
                    font_size = 16;
                    font_family = "Noto Sans";
                    rotate = 0; # degrees, counter-clockwise

                    position = "0, -80";
                    halign = "center";
                    valign = "center";
                }
            ];
        };

        extraConfig = ''
            auth {
                fingerprint {
                    enabled = true
                    ready_message = ...Or scan fingerprint to unlock
                    present_message = Scanning...
                    retry_delay = 250
                }
            }
        '';
    };
}