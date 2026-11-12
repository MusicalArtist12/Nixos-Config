{ ... }: {
    programs.niri.settings.spawn-at-startup = [
        { sh = "/usr/bin/env python ~/.local/bin/auto_statusbar.py --laptop --primary=eDP-1 --wm=niri"; }
    ];
}
