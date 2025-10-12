{ config, pkgs, ... } : {
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
        services.fprintd = {
            wantedBy = [ "multi-user.target" ];
            serviceConfig.Type = "simple";
        };
	};

	services = {
		greetd = {
			enable = false;
			settings = {
				default_session = {
					command = "Hyprland -c ${pkgs.nwg-hello}/etc/nwg-hello/hyprland.conf";
					user = "greeter";
				};
			};
		};
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
        blueman.enable = true;
        fprintd.enable = true;


	};

	services.power-profiles-daemon.enable = true;

	services.logind.settings.Login = {
		HandleLidSwitch = "suspend-then-hibernate";
		HandlePowerKey = "hibernate";
		HandlePowerKeyLongPress = "poweroff";
	};

	systemd.sleep.extraConfig = ''
		AllowSuspend=yes
		AllowHibernation=yes
		AllowHybridSleep=yes
		AllowSuspendThenHibernate=yes
		HibernateDelaySec=10m
		SuspendState=mem
		[Sleep]
		HibernateMode=shutdown
	'';


}