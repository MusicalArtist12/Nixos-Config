# { config, pkgs, catppuccin, inputs, lib, pkgs-stable, ... }:
{ config, pkgs, inputs, lib, pkgs-stable, ... }:
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
				name = "JetBrains Mono Nerd Font";
				size = theme.font_size;
				#name = "CommitMonoSimple";
				#size = theme.font_size;
				# package = inputs.pkgs-internal.packages.${pkgs.system}.commit-mono-simple;
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

	home.file.celeste-background = {
		source = ./celeste.png;
		target = "Pictures/Backgrounds/celeste.png";
	};



	home.packages = (with pkgs; [
		pokemon-colorscripts


		# bitwarden-desktop
		obsidian
		spotify
		inkscape
		foliate # ebook reader in gtk flavor
		# musescore
		(discord.override {
			withMoonlight = true;
			moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
		})

		libreoffice

		prismlauncher
		olympus

	]);

	# todo: vim and zsh

	imports = [
		./tools

		./rofi
		./sway
		./fetch

		./zsh
		./eww
		./power
		./hyprland/hyprpicker
		./swaync
		./vim
		./niri
		./theming.nix
	];


	home.sessionPath = ["/home/julia/.local/bin"];
	programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";

	# use home.file.<name> to link arbitrary file
}
