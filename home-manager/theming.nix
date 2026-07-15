# { config, pkgs, catppuccin, inputs, lib, pkgs-stable, ... }:
{ config, pkgs, inputs, lib, pkgs-stable, ... }:
let
    theme = (import ./theme.nix);
in
{
	# catppuccin = {
	# 	accent = "mauve";
	# 	flavor = "mocha";
	# 	kitty.enable = true;
	# 	cursors.enable = true; # this takes forever to build...
	# 	swaync.enable = true;
	# 	# firefox = {
	# 	# 	enable = true;
	# 	# 	force = true;
	# 	# };
	# 	swaync = {
	# 		font = theme.font;
	# 	};
	# 	spotify-player.enable = true;
	# };

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

	# # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
	#  gtk.gtk4.theme = config.gtk.theme;

	# xdg.configFile = {
  	# 	"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  	# 	"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  	# 	"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
	# };

	dconf.settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
	};
	# home.pointerCursor.enable = true;


}