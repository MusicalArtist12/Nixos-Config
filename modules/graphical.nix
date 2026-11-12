{
    pkgs,
    ...
}:
let
    wm_apps = with pkgs; [
        app2unit # uwsm
        hyprpolkitagent
        libnotify
        networkmanagerapplet
        polkit_gnome
        playerctl # cli util & library to control media players
        cliphist
        wl-clipboard
    ];
    sys_admin_apps = with pkgs; [
        brightnessctl
        kdePackages.filelight
        wev
    ];
    audio_stuff = with pkgs; [
        pamixer
        pavucontrol
        pulseaudio # provides pactl
    ];
    compat_tools = with pkgs; [
        wine-wayland
        labwc # a very useful utility
    ];
in
{
    environment.systemPackages = with pkgs; [
        wm_apps
        sys_admin_apps
        audio_stuff
        compat_tools
        multimedia_tools

        deluge # torrent client
        file-roller
        kitty
        nwg-icon-picker
        vlc
        imv # image viewer
    ];

    programs = {
        niri = {
            enable = true;
            package = pkgs.niri;
        };
        uwsm = {
            enable = true;
        };
        thunar = {
            enable = true;
            plugins = with pkgs; [
                thunar-archive-plugin
                thunar-volman
                thunar-vcs-plugin
                thunar-media-tags-plugin
            ];
        };

    };

    hardware.graphics = {
        enable = true;
    };

    systemd = {
        user.services.polkit-g-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };

    services = {
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };

        greetd = {
            enable = true;
            settings = rec {
                initial_session = {
                    command = "${pkgs.niri}/bin/niri-session";
                    user = "julia";
                };
                default_session = initial_session;
            };
        };

        desktopManager.gnome.enable = true;
        gnome.gnome-keyring.enable = true;

        # thunar stuff
        gvfs.enable = true;
        tumbler.enable = true;
    };

    security.pam.services = {
        greetd.enableGnomeKeyring = true;
        greetd-password.enableGnomeKeyring = true;
        hyprlock.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
    };

    services.gnome.core-apps.enable = true;
    services.gnome.core-developer-tools.enable = false;
    services.gnome.games.enable = false;
    environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-user-docs
        xdg-desktop-portal-gnome
    ];

    # nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
    systemd.user.services.niri-flake-polkit.enable = false;

    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
        };
        terminal-exec = {
            settings.default = [ "kitty.desktop" ];
            enable = true;
        };
    };

    environment.variables = {
        XDG_TERMINAL = "${pkgs.kitty}/bin/kitty";
        XDG_SYSTEM_MONITOR = "${pkgs.resources}/bin/resources";
    };

    # spotify networking
    networking.firewall.allowedTCPPorts = [ 57621 ];
    networking.firewall.allowedUDPPorts = [ 5353 ];

    fonts.packages = with pkgs; [
        commit-mono
        departure-mono
        font-awesome
        helvetica-neue-lt-std
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
    ];

    environment.pathsToLink = [
        "/share/wayland-sessions"
    ];

    security.rtkit.enable = true;
    security.polkit.enable = true;

}
