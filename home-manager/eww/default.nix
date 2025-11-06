{ pkgs, lib, config, ... }: {
    programs.eww = {
        enable = true;
        configDir = ./config;
        enableZshIntegration = true;
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
			};
		};
	};
}