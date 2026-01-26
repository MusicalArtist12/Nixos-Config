{ config, pkgs, inputs, catppuccin, ... } : {
	hardware.graphics = {
		enable = true;
	};

	systemd = {
		user.services.polkit-g-authentication-agent-1 = {
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
		displayManager.gdm.debug = true;
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
		gnome.gnome-keyring.enable = true;

		# thunar stuff
		gvfs.enable = true;
		tumbler.enable = true;
	};

	services.gnome.core-apps.enable = true;
	services.gnome.core-developer-tools.enable = false;
	services.gnome.games.enable = false;
	environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs xdg-desktop-portal-gnome ];

	programs = {
		hyprland = {
			enable = true;
			withUWSM = true;
			xwayland.enable = true;
		};
		sway = {
			enable = true;
			xwayland.enable = true;

		};

		gamemode.enable = true;
		uwsm = {
			waylandCompositors = {
				sway = {
					prettyName = "Sway";
					comment = "Sway compositor managed by UWSM";
					binPath = "${pkgs.sway}/bin/sway";

				};
			};
			enable = true;
		};
		thunar = {
			enable = true;
			plugins = with pkgs; [
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
		light.enable = true;

	};


	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
	};
	xdg.terminal-exec.settings = {
		default = ["kitty.desktop"];
	};

	xdg.terminal-exec.enable = true;
	environment.variables.XDG_TERMINAL = "${pkgs.kitty}/bin/kitty";
	environment.variables.XDG_SYSTEM_MONITOR = "${pkgs.resources}/bin/resources";


	environment.systemPackages = with pkgs; [
		nwg-displays
		nwg-icon-picker
		nwg-hello

		polkit_gnome
		hyprpolkitagent

		hyprshot

		app2unit # uwsm

		cliphist
		wl-clipboard

		libnotify
		swaynotificationcenter
		syshud

		networkmanagerapplet

		pulseaudio # provides pactl
		pamixer
		pavucontrol
		playerctl

		kitty
		vlc

		file-roller
		wev

		gdm-settings
		imv

		kdePackages.filelight


	];

	# spotify networking
	networking.firewall.allowedTCPPorts = [ 57621 ];
	networking.firewall.allowedUDPPorts = [ 5353 ];

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		noto-fonts
		noto-fonts-color-emoji
		noto-fonts-cjk-sans
		font-awesome
		helvetica-neue-lt-std
		departure-mono
	];

	environment.pathsToLink = [
		"/share/wayland-sessions"
	];

	security.rtkit.enable = true;
	security.polkit.enable = true;



}
