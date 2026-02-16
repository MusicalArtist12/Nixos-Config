{ pkgs, lib, config, ... }:
let
    theme = (import ../theme.nix);
    programs = (import ../programs.nix);
    accent = theme.mauve_hex;
in
{
	# hyprlock has better fingerprint support
	imports = [
		../hyprland/hyprlock.nix
	];

	services.swayidle = {
		enable = true;
		events = {
			"before-sleep" = "${pkgs.hyprlock}/bin/hyprlock --no-fade-in --immediate-render";
			"lock" = "${pkgs.hyprlock}/bin/hyprlock --no-fade-in --immediate-render";
		};
		extraArgs = [];
	};

	wayland.windowManager.sway.checkConfig = false;
    wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
		systemd.enable = true;

		config = rec {
			terminal = "app2unit -- kitty";
			modifier = "Mod4";

			keybindings = let
				modifier = config.wayland.windowManager.sway.config.modifier;
			in {
				"${modifier}+Shift+L" = "exec loginctl lock-session";
				# "${modifier}+Shift+E" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

				"Print" = "exec ${programs.screenshot_window}";
				"${modifier}+Shift+S" = "exec ${programs.screenshot}";

				"${modifier}+Return" = "exec app2unit -- kitty";
				"${modifier}+P" = "exec ${programs.python_term}";
				"${modifier}+Shift+Return" = "exec thunar";

				"${modifier}+C" = "exec ${programs.clipboard}";
				"${modifier}+D" = "exec ${programs.menu}";
				"XF86Tools" = "exec ${programs.menuPower}";
				"${modifier}+Escape" = "exec ${programs.menuPower}";

				"${modifier}+1" = "workspace number 1";
				"${modifier}+2" = "workspace number 2";
				"${modifier}+3" = "workspace number 3";
				"${modifier}+4" = "workspace number 4";
				"${modifier}+5" = "workspace number 5";
				"${modifier}+6" = "workspace number 6";
				"${modifier}+7" = "workspace number 7";
				"${modifier}+8" = "workspace number 8";
				"${modifier}+9" = "workspace number 9";
				"${modifier}+0" = "workspace number 10";

				"${modifier}+Shift+1" = "move container to workspace number 1";
				"${modifier}+Shift+2" = "move container to workspace number 2";
				"${modifier}+Shift+3" = "move container to workspace number 3";
				"${modifier}+Shift+4" = "move container to workspace number 4";
				"${modifier}+Shift+5" = "move container to workspace number 5";
				"${modifier}+Shift+6" = "move container to workspace number 6";
				"${modifier}+Shift+7" = "move container to workspace number 7";
				"${modifier}+Shift+8" = "move container to workspace number 8";
				"${modifier}+Shift+9" = "move container to workspace number 9";
				"${modifier}+Shift+0" = "move container to workspace number 10";

				"${modifier}+Down" = "focus down";
				"${modifier}+Up" = "focus up";
				"${modifier}+Left" = "focus left";
				"${modifier}+Right" = "focus right";
				"${modifier}+a" = "focus parent";


				"${modifier}+Shift+Down" = "move down";
				"${modifier}+Shift+Up" = "move up";
				"${modifier}+Shift+Left" = "move left";
				"${modifier}+Shift+Right" = "move right";


				"${modifier}+Space" = "exec swaync-client -t";

				"XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
				"XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
				"${modifier}+XF86AudioRaiseVolume" = "exec python ~/.local/bin/sink_switcher.py -n";
				"${modifier}+XF86AudioLowerVolume" = "exec python ~/.local/bin/sink_switcher.py -p";

				"XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
				"XF86MonBrightnessUp" =   "exec light -A 10";
				"XF86MonBrightnessDown" = "exec light -U 10";

				"XF86AudioPlay" = "exec playerctl play-pause";
				"XF86AudioNext" = "exec playerctl next";
				"XF86AudioPrev" = "exec playerctl previous";


				"${modifier}+Shift+F" = "floating toggle";
				"${modifier}+F" = "fullscreen toggle";
				"${modifier}+Shift+Q" = "kill";
				"${modifier}+Shift+R" = "reload";

				"${modifier}+e" = "layout toggle split";
				"${modifier}+s" = "layout stacking";
				"${modifier}+w" = "layout tabbed";

				# "${modifier}+r" = "mode gaps; exec swaynag -m 'gaps mode'";


			};
			startup = [

				{command = "app2unit -- discord.desktop";}
				{command = "app2unit -- spotify.desktop";}

				{command = "app2unit -- thunar --daemon";}
				{command = "systemctl --user start tumblerd.service";}
			];

			gaps = {
				inner = 5;
				outer = 5;
			};
			window = {
				titlebar = false;
			};

			colors = {
				focused = {
					background = accent;
					border = accent;
					text = theme.surface0_hex;
					childBorder = accent;
					indicator = accent;
				};
				unfocused = {
					background = theme.surface0_hex;
					border = theme.surface0_hex;
					text = theme.text_hex;
					childBorder = theme.surface0_hex;
					indicator = theme.surface0_hex;
				};
			};

			assigns = {
				"10" = [
					{ class = "discord"; }
					{ class = "spotify"; }
				];
			};

			up = "Ctrl+Up";
			down = "Ctrl+Down";
			left = "Ctrl+Left";
			right = "Ctrl+Right";

			defaultWorkspace = "workspace number 1";
			menu = programs.menu;
			bars = [];
			seat = {
				"*" = {
					xcursor_theme = "catppuccin-mocha-mauve-cursors 36";
				};
			};
			input = {
				"5426:152:Razer_Razer_DeathAdder_Essential_Keyboard" = {
					pointer_accel = "-0.5";
				};
			};

			modes = {
				gaps = {

					# Binds arrow keys to resizing commands
					"PLUS" = "gaps outer all plus 10px";
					"MINUS" = "gaps outer all minus 10px";
					# "SHIFT+EQUAL" = "gaps all inner plus 10px";
					# "SHIFT+MINUS" = "gaps all inner minus 10px";

					# Exit resize mode
					"Escape" = "mode default; exec killall swaynag";
					"Return" = "mode default; exec killall swaynag";
				};
			};
		};

	};

	home.file.sink_switcher = {
        source = ./sink_switcher.py;
        target = ".local/bin/sink_switcher.py";
        executable = true;
    };
	home.file.swaykill = {
        source = ./swaykill.py;
        target = ".local/bin/swaykill";
        executable = true;
    };
}