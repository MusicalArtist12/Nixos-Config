{ ... }:
let
    theme = (import ../theme.nix);
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
                    dots_size = 0.33;
                    dots_spacing = 0.15;
                    dots_center = false;
                    dots_rounding = -1;
                    dots_fade_time = 200;
                    outer_color = accent;
                    inner_color = theme.crust;
                    font_color = theme.text;
                    font_family = "Noto Sans";
                    fade_on_empty = false;
                    fade_timeout = 1000;
                    placeholder_text = "<i>Input password...</i>";
                    hide_input = false;
                    rounding = -1;
                    check_color = theme.yellow;
                    fail_color = theme.red;
                    fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
                    fail_timeout = 2000;
                    fail_transition = 300;
                    capslock_color = theme.red;
                    numlock_color = theme.red;
                    bothlock_color = -1;
                    invert_numlock = false;
                    swap_font_color = false;

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
                    rotate = 0;

                    position = "0, 140";
                    halign = "center";
                    valign = "center";
                }
                {
                    text = "$TIME";
                    text_align = "center";
                    color = theme.text;
                    font_size = 40;
                    font_family = "Noto Sans";
                    rotate = 0;

                    position = "0, 60";
                    halign = "center";
                    valign = "center";
                }
                {
                    text = "$FPRINTPROMPT";
                    color = theme.text;
                    font_size = 16;
                    font_family = "Noto Sans";
                    rotate = 0;

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