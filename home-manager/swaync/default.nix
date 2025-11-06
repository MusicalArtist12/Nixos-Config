{ pkgs, lib, config, ... }: {
    home.file.swaync = {
        recursive = true;
		source = ./config;
		target = ".config/swaync";
    };

}