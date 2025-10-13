{ ... }:
{
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
						key = "╰─   ";
						type = "shell";
						keyColor = "red";
					}
					{
						key = "╭ Framework ";
						type = "host";
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
						key = "╰─ 󰍹  ";
						type = "display";
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
					"break"
					{
						type = "colors";
						symbol = "block";
					}
				];
			};
		};
    };
}