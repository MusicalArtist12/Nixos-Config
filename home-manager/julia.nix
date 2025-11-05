{ config, pkgs, catppuccin, inputs, ... }:
let
    theme = (import ./theme.nix);
in
{
	home.username = "julia";
	home.homeDirectory = "/home/julia";
	home.stateVersion = "25.05";

	programs = {
		eww = {
			enable = true;
			configDir = ./eww;
			enableZshIntegration = true;
		};
		kitty = {
			enable = true;
			enableGitIntegration = true;
			font = {
				name = theme.font;
				size = theme.font_size;
				package = pkgs.nerd-fonts.jetbrains-mono;
			};
			settings = {
				confirm_os_window_close = 0;
			};
			shellIntegration.enableZshIntegration = true;
			themeFile = "Catppuccin-Mocha";
		};
		git = {
			enable = true;
			settings.user = {
				name = "MusicalArtist12";
				email = "TheMusicalArtist12@gmail.com";
			};

			lfs.enable = true;
		};
		firefox = {
			enable = true;
		};
	};

	systemd.user.services = {
		eww-daemon = {
			Unit = {
				Description = "Eww Daemon";

			};
			Service = {
				ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
			};
		};
	};

	home.packages = with pkgs; [
		pokemon-colorscripts
		zoom

		vscode
		gimp
		blender
		godot
		bitwarden-desktop
		obsidian
		spotify
		inkscape
		(discord.override {
			withMoonlight = true;
			moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
		})
	];

	# todo: vim and zsh

	imports = [
		./rofi
		./sway
		./fetch.nix
		./gtk.nix
	];

	catppuccin = {
		accent = "mauve";
		flavor = "mocha";
		kitty.enable = true;
		cursors.enable = true;
		swaync.enable = true;
		# firefox = {
		# 	enable = true;
		# 	force = true;
		# };
		swaync = {
			font = theme.font;
		};
		spotify-player.enable = true;

	};

	# use home.file.<name> to link arbitrary file
}
