{
    terminal = "kitty.desktop";
    fileManager = "thunar.desktop";
    menu = "rofi -show combi -show-icons -run-command 'app2unit -- {cmd}' -drun-exclude-categories System";
    menuPower = "rofi -show drun -show-icons -run-command 'app2unit -- {cmd}' -drun-categories Session";

    clipboard = "rofi -show clipboard -show-icons";
    python_term = "kitty --hold python";
    screenshot = "hyprshot -m region --clipboard-only";
    screenshot_window = "hyprshot -m window -m active -- imv";
}