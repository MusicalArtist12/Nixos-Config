{ pkgs, lib, config, ... }: {

	home.file.getWorkspace = {
        source = ./bin/getWorkspace.sh;
        target = ".local/bin/getWorkspace.sh";
        executable = true;
    };
	home.file.getWorkspaceNiri = {
        source = ./bin/getWorkspaceNiri.sh;
        target = ".local/bin/getWorkspaceNiri.sh";
        executable = true;
    };
	home.file.auto_statusbar = {
        source = ./bin/auto_statusbar.py;
        target = ".local/bin/auto_statusbar.py";
        executable = true;
    };

	imports = [
        ./scssConfig.nix
		./yuckConfig.nix
    ];

    programs.eww = {
        enable = true;
    };
    systemd.user.services = {
		eww-daemon = {
			Unit = {
				Description = "Eww Daemon";

			};
			Service = {
				Environment = [
					"PATH=/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
				];
				ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
				After = "graphical-session.target";
				BindsTo = "graphical-session.target";
			};
		};
	};


	wayland.windowManager.sway.config.startup = [
		{command = "app2unit -- nm-applet";}
	];
}