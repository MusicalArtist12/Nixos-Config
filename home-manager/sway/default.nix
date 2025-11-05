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
		events = [
			{ event = "before-sleep"; command = "${pkgs.hyprlock}/bin/hyprlock"; }
			{ event = "lock"; command = "${pkgs.hyprlock}/bin/hyprlock"; }
		];
		# timeouts = [
		# 	{ timeout = 60; command = "if pgrep hyprlock; then systemctl sleep; fi"; }
		#
		# ];
	};

	wayland.windowManager.sway.checkConfig = false;
    wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true;

		config = rec {
			terminal = "app2unit -- kitty";
			modifier = "Mod4";

			keybindings = let
				modifier = config.wayland.windowManager.sway.config.modifier;
			in lib.mkOptionDefault {
				"${modifier}+Shift+L" = "exec loginctl lock-session";
				"${modifier}+Shift+S" = "exec ${programs.screenshot}";
				"${modifier}+Shift+Return" = "exec thunar";

				"XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
				"XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
				"XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
				"XF86MonBrightnessUp" =   "exec light -A 10";
				"XF86MonBrightnessDown" = "exec light -U 10";
				"XF86AudioPlay" = "exec playerctl play-pause";
				"XF86AudioNext" = "exec playerctl next";
				"XF86AudioPrev" = "exec playerctl previous";

				"XF86Tools" = "exec ${programs.menuPower}";

				"${modifier}+g" = "layout tabbed";
				"${modifier}+e" = "layout toggle split";

			};
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
			up = "i";
			down = "o";
			left = "u";
			right = "p";
			defaultWorkspace = "workspace number 1";
			menu = programs.menu;
			bars = [];
				seat = {
					"*" = {
						xcursor_theme = "catppuccin-mocha-mauve-cursors 36";
					};
				};
		};

	};
}