{ pkgs, lib, config, ... }: {
    home.file = {
		system-power = {
			recursive = true;
			source = ./apps;
			target = ".local/share/applications/system";
		};
	};

}