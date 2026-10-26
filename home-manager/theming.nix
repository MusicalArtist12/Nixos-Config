# { config, pkgs, catppuccin, inputs, lib, pkgs-stable, ... }:
{
    config,
    pkgs,
    inputs,
    lib,
    pkgs-stable,
    ...
}:
let
    theme = (import ./theme.nix);
in
{
    gtk = {
        enable = true;
        theme = {
            name = "catppuccin-mocha-mauve-standard+normal";
            package = pkgs.catppuccin-gtk.override {
                accents = [ "mauve" ];
                size = "standard";
                tweaks = [ "normal" ];
                variant = "mocha";
            };
        };
        iconTheme = {
            package = pkgs.papirus-icon-theme;
            name = "Papirus-Dark";
        };
        font.name = "Noto Sans";
        font.size = theme.font_size;
    };

    gtk.gtk4.theme = null;

    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };

}
