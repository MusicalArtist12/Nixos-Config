{ ... }: {
    programs.niri.settings.spawn-at-startup = [
        { sh = "/usr/bin/env python ~/.local/bin/auto_statusbar.py --primary=DP-3 --wm=niri"; }
    ];
}
