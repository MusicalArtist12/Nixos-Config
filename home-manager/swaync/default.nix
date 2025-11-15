{ pkgs, lib, config, ... }: {
    home.file.swaync = {
        recursive = true;
		source = ./config;
		target = ".config/swaync";
    };

    wayland.windowManager.sway.config.startup = [
		{command = "app2unit -- syshud";}
	];
}