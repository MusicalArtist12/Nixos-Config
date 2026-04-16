{ pkgs, lib, config, ... }: {
    services.swayidle = {
		enable = true;
		events = {
			"before-sleep" = "${pkgs.hyprlock}/bin/hyprlock --no-fade-in --immediate-render";
			"lock" = "${pkgs.hyprlock}/bin/hyprlock --no-fade-in --immediate-render";
		};
		extraArgs = [];
		systemdTarget = "graphical-session.target";
	};
}