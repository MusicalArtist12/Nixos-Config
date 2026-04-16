{ ... }:
let
    theme = (import ../theme.nix);
    accent = theme.mauve;

    block_pos = "0, 0";
    block_size = "33.33%, 100%";

    # defines coordinate 0, 0
    halign = "center";
    valign = "center";

    time_loc_h = "-33.33%,  ${builtins.toString(300 + 100)}";
    time_loc_m = "-33.33%,  ${builtins.toString(300 - 100 - 20)}";
    time_loc_d = "-33.33%,  ${builtins.toString(300 - 100 - 20 - 100 - 8 - 20)}"; # center line through text
    battery_loc = "-33.33%, ${builtins.toString(300 - 100 - 20 - 100 - 8 - 20 - 16 - 20)}"; # 16

    username_loc = "-33.33%, ${builtins.toString(- 400 + 16)}";
    input_field_loc = "-33.33%, ${builtins.toString(- 400 - 40 - 28)}"; # offset, username, space, input
    fprint_text_loc = "-33.33%, ${builtins.toString(- 400 - 40 - 56 - 40 - 8)}"; # offset username space input space fprint

    input_field_size = "400, 50";
    time_font_size = 200;
    date_font_size = 16;
    username_text_size = 32;
    fprint_text_size = 16;

    battery_script = ".local/bin/battery.sh";
in
{

    home.file.battery_script= {
		source = ./hyprlock_scripts/battery.sh;
		target = battery_script;
        executable = true;
	};

    programs.hyprlock = {
        enable = true;
        settings = {
            general = {
                hide_cursor = true;
            };
            background = {
                # color = theme.base;
                path = "/home/julia/Pictures/Backgrounds/celeste.png";
                blur_passes = 0;
            };
            animations.enabled = false;
            shape = {
                rounding = 0;
                xray = false;
                size = block_size;
                halign = "left";
                valign = "center";
                position = block_pos;
                color = "rgba(0, 0, 0, 0.8)";
            };
            input-field = [
                {
                    size = input_field_size;
                    outline_thickness = 3;
                    dots_size = 0.33;
                    dots_spacing = 0.15;
                    dots_center = false;
                    dots_rounding = -1;
                    dots_fade_time = 200;
                    outer_color = accent;
                    inner_color = theme.crust;
                    font_color = theme.text;
                    font_family = "CommitMonoSimple";
                    fade_on_empty = false;
                    fade_timeout = 1000;
                    placeholder_text = "<i>Input password...</i>";
                    hide_input = false;
                    rounding = -1;
                    check_color = theme.yellow;
                    fail_color = theme.red;
                    fail_text = "<i>Incorrect <b>($ATTEMPTS)</b></i>";
                    fail_timeout = 2000;
                    fail_transition = 300;
                    capslock_color = theme.red;
                    numlock_color = theme.red;
                    bothlock_color = -1;
                    invert_numlock = false;
                    swap_font_color = false;

                    position = input_field_loc;
                    halign = halign;
                    valign = valign;
                }
            ];
            label = [

                {
                    text = "cmd[update:1000] echo -e \"$(date +\"%H\")\"";
                    text_align = "center";
                    color = accent;
                    font_size = time_font_size;
                    font_family = "CommitMonoSimple";
                    halign = halign;
                    valign = valign;
                    position = time_loc_h;
                }
                {
                    text = "cmd[update:1000] echo -e \"$(date +\"%M\")\"";
                    text_align = "center";
                    color = theme.text;
                    font_size = time_font_size;
                    font_family = "CommitMonoSimple";
                    halign = halign;
                    valign = valign;
                    position = time_loc_m;
                }
                {
                    text = "cmd[update:1000] echo -e \"$(date +\"%A %B %d, %Y\")\"";
                    text_align = "center";
                    color = theme.text;
                    font_size = date_font_size;
                    font_family = "CommitMonoSimple";
                    halign = halign;
                    valign = valign;
                    position = time_loc_d;
                }
                {
                    text = "cmd[update:1000] echo -e \"$(~/${battery_script})\"";
                    text_align = "center";
                    color = theme.text;
                    font_size = date_font_size;
                    font_family = "CommitMonoSimple";
                    halign = halign;
                    valign = valign;
                    position = battery_loc;
                }

                {
                    text = "Welcome Back, Julia";
                    color = theme.text;
                    font_size = username_text_size;
                    font_family = "CommitMonoSimple";
                    rotate = 0;
                    text_align = "center";

                    position = username_loc;
                    halign = halign;
                    valign = valign;
                }
                {
                    text = "$FPRINTPROMPT";
                    color = theme.text;
                    font_size = fprint_text_size;
                    font_family = "CommitMonoSimple";
                    rotate = 0;
                    text_align = "center";

                    position = fprint_text_loc;
                    halign = halign;
                    valign = valign;
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