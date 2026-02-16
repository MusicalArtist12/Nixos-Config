{ ... }:
let
	logo_path = ".config/fastfetch/lixos.txt";
in
{
	home.file."lixos.txt" = {
		enable = true;
		source = ./lixos.txt;
		target = logo_path;
	};
    programs = {
		hyfetch = {
			enable = true;
			settings = {
				preset = "lesbian";
				mode = "rgb";
				auto_detect_light_dark = true;
				light_dark = "dark";
				lightness = 0.65;
				color_align = {
					mode = "horizontal";
				};
				backend = "fastfetch";
				args = null;
				distro = null;
				pride_month_disable = false;
			};
		};
		fastfetch = {
			enable = true;
			settings = {
				logo = {
					source = "~/${logo_path}";
					color = {
						"1" = "38;2;255;101;73";
						"2" = "38;2;255;155;86";
						"3" = "38;2;255;82;167";
						"4" = "38;2;222;117;178";

					};
				};
				display = {
					separator = "";
					color = {
						keys = "green";
						title = "green";
					};
					disableLinewrap = true;
				};
				modules = [
					{
						type = "title";
						key = " ";
						format = "";
					}
					{
						key = "╭ Distro ";
						type = "os";
						keyColor = "red";
					}
					{
						key = "├─   ";
						type = "kernel";
						keyColor = "red";
					}
					{
						key = "├─   ";
						type = "packages";
						keyColor = "red";
					}
					{
						key = "├─   ";
						type = "shell";
						keyColor = "red";
					}
					{
						key  = "╰─   ";
						type = "wm";
						keyColor = "red";
					}
					{
						key = "╭ Current Machine";
						type = "custom";
						keyColor = "cyan";
					}
					{
						key = "├─ 󰻠  ";
						type = "cpu";
						keyColor = "cyan";
					}
					{
						key = "├─ 󰍛  ";
						type = "gpu";
						keyColor = "cyan";
					}
					{
						key = "├─ 󰍹  ";
						type = "display";
						keyColor = "cyan";
					}
					{
						key = "╰─   ";
						type = "host";
						keyColor = "cyan";
					}
					{
						key = "╭ Status ";
						type = "custom";
						keyColor = "blue";
					}
					{
						key = "├─   ";
						type = "uptime";
						keyColor = "blue";
					}
					{
						key = "├─ 󰩟  ";
						type = "localip";
						keyColor = "blue";
						showIpv4 = true;
						showIpv6 = true;
						showMac = true;
					}
					{
						type = "battery";
						key = "├─ 󰁹  ";
						percent = {
							green = 50;
							yellow = 10;
						};
						keyColor = "blue";
					}
					{
						key = "├─   ";
						type = "cpuusage";
						separate = true;
						"percent" = {
							green = 50;
							yellow = 80;
						};
						keyColor = "blue";
					}
					{
						key = "├─   ";
						type = "disk";
						keyColor = "blue";
					}
					{
						key = "├─   ";
						type = "memory";
						keyColor = "blue";
					}
					{
						key = "╰─   ";
						type = "swap";
						keyColor = "blue";
					}

				];
			};
		};
    };
}