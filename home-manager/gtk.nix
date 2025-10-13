{ pkgs, config, ... }:
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
	};
	# Now symlink the `~/.config/gtk-4.0/` folder declaratively:
	xdg.configFile = {
  		"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  		"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  		"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
	};
	dconf.settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
	};
    home.pointerCursor = {
		gtk.enable = true;
		package = pkgs.catppuccin-cursors.mochaMauve;
		name = "Catppuccin-Mocha-Mauve-Cursors";
		size = 8;
	};

}