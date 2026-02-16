{ config, pkgs, catppuccin, inputs, lib, pkgs-stable, ... }:
let
    theme = (import ./theme.nix);
in
{
	home.username = "julia";
	home.homeDirectory = "/home/julia";
	home.stateVersion = "25.05"; # no touchy

	programs = {

		kitty = {
			enable = true;
			enableGitIntegration = true;
			font = {
				name = "CommitMonoSimple";
				size = theme.font_size;
				package = inputs.pkgs-internal.packages.${pkgs.system}.commit-mono-simple;
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



	home.packages = (with pkgs; [
		pokemon-colorscripts
		zoom

		vscode
		gimp
		blender
		bitwarden-desktop
		obsidian
		spotify
		inkscape
		foliate # ebook reader in gtk flavor
		musescore
		(discord.override {
			withMoonlight = true;
			moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
		})
	]) ++ [
		pkgs-stable.godotPackages_4_6.godot
		pkgs-stable.godotPackages_4_6.export-templates-bin
	];

	# todo: vim and zsh

	imports = [
		./tools

		./rofi
		./sway
		./fetch
		./gtk.nix
		./zsh
		./eww
		./power
		./hyprland/hyprpicker
		./swaync
		./vim
		./niri
	];

	catppuccin = {
		accent = "mauve";
		flavor = "mocha";
		kitty.enable = true;
		cursors.enable = true; # this takes forever to build...
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

	home.sessionPath = ["/home/julia/.local/bin"];


	# use home.file.<name> to link arbitrary file
}
