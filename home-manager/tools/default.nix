{ pkgs, lib, config, ... }: {
    home.file.sink_switcher = {
        source = ./sink_switcher.py;
        target = ".local/bin/sink_switcher.py";
        executable = true;
    };
}