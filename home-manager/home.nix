{ config, pkgs, moonlight, ... }: {
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
				name = "Jetbrains Mono Nerd Font";
				size = 12;
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
			userName = "MusicalArtist12";
			userEmail = "TheMusicalArtist12@gmail.com";
		};

	};


	home.packages = with pkgs; [
		pokemon-colorscripts
		hyfetch
		zoom
		godot
		vscode
		gimp
		blender
		bitwarden-desktop
		obsidian
		spotify
		(discord.override {
			moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
		})
	];

	imports = [
		./hyprland/default.nix
		./gtk.nix
		./rofi/default.nix
		./fetch.nix
	];

}
