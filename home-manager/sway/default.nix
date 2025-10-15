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
		../hyprland/hypridle.nix
	];

	wayland.windowManager.sway.checkConfig = false;
    wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
		config = rec {
			terminal = "app2unit -- kitty";
			modifier = "Mod4";
			startup = [
				{command = "app2unit -- eww open statusbar-primary";}
				{command = "app2unit -- syshud";}
				{command = "app2unit -- discord.desktop";}
				{command = "app2unit -- spotify.desktop";}
				{command = "app2unit -- nm-applet";}
				{command = "app2unit -- wl-paste --type text --watch cliphist store";}
				{command = "app2unit -- wl-paste --type image --watch cliphist store";}
				{command = "app2unit -- thunar --daemon";}
				{command = "app2unit -- systemctl --user start tumblerd.service";}
			];
			keybindings = let
				modifier = config.wayland.windowManager.sway.config.modifier;
			in lib.mkOptionDefault {
				"${modifier}+Shift+L" = "exec loginctl lock-session";
				"${modifier}+Shift+S" = "exec ${programs.screenshot}";
				"${modifier}+Shift+Return" = "exec thunar";
				"XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
				"XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
				"XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
				"XF86MonBrightnessUp" =   "exec brightnessctl s +5%";
				"XF86MonBrightnessDown" = "exec brightnessctl s 5%-";
				"XF86AudioPlay" = "exec playerctl play-pause";
				"XF86AudioNext" = "exec playerctl next";
				"XF86AudioPrev" = "exec playerctl previous";
			};
			gaps = {
				inner = 5;
				outer = 5;
			};
			output = {
				eDP-1 = {
					bg = "/home/julia/Pictures/Backgrounds/celeste.png fill";
					color_profile = "icc /home/julia/.config/Framework16.icm";
				};
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
			up = "i";
			down = "o";
			left = "u";
			right = "p";
			defaultWorkspace = "workspace number 1";
			menu = programs.menu;
			bars = [];
			seat = {
				"*" = {
					xcursor_theme = "Catppuccin-Mocha-Mauve-Cursors 8";
				};
			};
		};

	};
}