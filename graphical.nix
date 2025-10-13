{ config, pkgs, inputs, ... } : {
	hardware.graphics = {
		enable = true;
	};

	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
				description = "polkit-gnome-authentication-agent-1";
				wantedBy = [ "graphical-session.target" ];
				wants = [ "graphical-session.target" ];
				after = [ "graphical-session.target" ];
				serviceConfig = {
					Type = "simple";
					ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
					Restart = "on-failure";
					RestartSec = 1;
					TimeoutStopSec = 10;
	  			};
  		};
	};

	services = {
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};

		displayManager.gdm.enable = true;
		gnome.gnome-keyring.enable = true;

		# thunar stuff
		gvfs.enable = true;
		tumbler.enable = true;
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

		polkit_gnome
		hyprpolkitagent

		hyprpicker
		hyprshot

		app2unit # uwsm

		cliphist
		wl-clipboard

		libnotify
		swaynotificationcenter
		syshud

		rofi
		networkmanagerapplet

		pulseaudio # provides pactl
		pamixer
		pavucontrol

		kitty
		firefox
		vlc

		file-roller
		wev
	];

	# spotify networking
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
