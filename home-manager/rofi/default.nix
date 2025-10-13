{ ... }:
{
    programs.rofi = {
		enable = true;
		theme = ./theme.rasi;
		font = "Jetbrains Mono Nerd Font 12";
		extraConfig = {
			combi-modi ="drun,window";
			combi-display-format = "{mode}&#09;{text}";
			drun-display-format = "&#09;{name}";
			window-format = "{w}&#09;{t}";
			modes = "combi,window,drun,clipboard:~/.local/bin/rofi-clipboard.sh";
		};
	};
}
