{ config, pkgs, inputs, ... } : {
	hardware.graphics = {
		enable = true;
	};

	programs = {
		hyprland = {
			enable = true;
			withUWSM = true;
			xwayland.enable = true;
		};
		thunar = {
			enable = true;
			plugins = with pkgs.xfce; [
				thunar-archive-plugin
				thunar-volman
				thunar-vcs-plugin
				thunar-media-tags-plugin
			];
		};
		steam = {
			enable = true;
			gamescopeSession.enable = true;
			remotePlay.openFirewall = true;
			localNetworkGameTransfers.openFirewall = true;
		};
	};

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
	};
	xdg.terminal-exec.settings = {
		default = ["kitty.desktop"];
	};

	environment.systemPackages = with pkgs; [
		nwg-displays
		nwg-icon-picker
		nwg-hello

		hyprpolkitagent
		hyprpicker
		hyprshot
		hyprlock
		hypridle
		hyprpaper
		app2unit

		cliphist
		wl-clipboard

		libnotify
		swaynotificationcenter
		eww
		syshud
		rofi
		networkmanagerapplet
		pavucontrol

		polkit_gnome
		pulseaudio # provides pactl
                pamixer

		kitty
		firefox
		vlc

		file-roller
		wev

		zoom
		godot
		vscode
		gimp
		blender



		bitwarden-desktop
		obsidian
		spotify
		(discord.override {
			withMoonlight = true;
			moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
		})
	];

	# spotifty networking
	networking.firewall.allowedTCPPorts = [ 57621 ];
	networking.firewall.allowedUDPPorts = [ 5353 ];

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];

	environment.pathsToLink = [
		"/share/wayland-sessions"
	];

	security.rtkit.enable = true;
	security.polkit.enable = true;

	environment.sessionVariables.NIXOS_OZONE_WL = "1";



}
