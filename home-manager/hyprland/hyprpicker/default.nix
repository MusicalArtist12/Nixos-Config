{ pkgs, ... }: {
    home.file.hyprpicker-extended = {
        source = ./hyprpicker-extended.sh;
        target = ".local/bin/hyprpicker-extended.sh";
        executable = true;
    };
    home.file.hyprpicker-desktop = {
        source = ./Hyprpicker.desktop;
        target = ".local/share/applications/Hyprpicker.desktop";
    };

    home.packages = (with pkgs; [
        hyprpicker
        imagemagick
    ]);
}