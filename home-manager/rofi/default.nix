{ ... }:
let
    theme = (import ../theme.nix);
in
{
    programs.rofi = {
		enable = true;
		theme = ./config/theme.rasi;
		font = "${theme.font} 16";
		extraConfig = {
			combi-modi ="drun,window";
			combi-display-format = "{mode}&#09;{text}";
			drun-display-format = "&#09;{name}";
			window-format = "{w}&#09;{t}";
			modes = "combi,window,drun,clipboard:~/.local/bin/rofi-clipboard.sh";
		};
	};

	home.file.rofi-clipboard = {
		source = ./config/rofi-clipboard.sh;
		target = ".local/bin/rofi-clipboard.sh";
		executable = true;
	};

	wayland.windowManager.sway.config.startup = [
		{command = "app2unit -- wl-paste --type text --watch cliphist store";}
		{command = "app2unit -- wl-paste --type image --watch cliphist store";}
	];
}
