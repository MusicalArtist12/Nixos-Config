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
                modules =
                    let
                        batteryPercent = {
                            green = 50;
                            yellow = 10;
                        };
                        cpuUsagePercent = {
                            green = 50;
                            yellow = 80;
                        };
                        distroCol = "red";
                        currMachineCol = "cyan";
                        statusCol = "green";
                    in
                    [
                        {
                            type = "title";
                            key = " ";
                            format = "";
                        }
                        {
                            key = "╭ Distro ";
                            type = "os";
                            keyColor = distroCol;
                        }
                        {
                            key = "├─   ";
                            type = "kernel";
                            keyColor = distroCol;
                        }
                        {
                            key = "├─   ";
                            type = "packages";
                            keyColor = distroCol;
                        }
                        {
                            key = "├─   ";
                            type = "shell";
                            keyColor = distroCol;
                        }
                        {
                            key = "╰─   ";
                            type = "wm";
                            keyColor = distroCol;
                        }
                        {
                            key = "╭ Current Machine";
                            type = "custom";
                            keyColor = currMachineCol;
                        }
                        {
                            key = "├─ 󰻠  ";
                            type = "cpu";
                            keyColor = currMachineCol;
                        }
                        {
                            key = "├─ 󰍛  ";
                            type = "gpu";
                            keyColor = currMachineCol;
                        }
                        {
                            key = "├─ 󰍹  ";
                            type = "display";
                            keyColor = currMachineCol;
                        }
                        {
                            key = "╰─   ";
                            type = "host";
                            keyColor = currMachineCol;
                        }
                        {
                            key = "╭ Status ";
                            type = "custom";
                            keyColor = statusCol;
                        }
                        {
                            key = "├─   ";
                            type = "uptime";
                            keyColor = statusCol;
                        }
                        {
                            key = "├─ 󰩟  ";
                            type = "localip";
                            keyColor = statusCol;
                            showIpv4 = true;
                            showIpv6 = true;
                            showMac = true;
                        }
                        {
                            key = "├─ 󰁹  ";
                            type = "battery";
                            percent = batteryPercent;
                            keyColor = statusCol;
                        }
                        {
                            key = "├─   ";
                            type = "cpuusage";
                            separate = true;
                            "percent" = cpuUsagePercent;
                            keyColor = statusCol;
                        }
                        {
                            key = "├─   ";
                            type = "disk";
                            keyColor = statusCol;
                        }
                        {
                            key = "├─   ";
                            type = "memory";
                            keyColor = statusCol;
                        }
                        {
                            key = "╰─   ";
                            type = "swap";
                            keyColor = statusCol;
                        }
                    ];
            };
        };
    };
}
