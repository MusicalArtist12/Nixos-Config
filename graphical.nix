{
    config,
    pkgs,
    inputs,
    catppuccin,
    ...
}:
{
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
            jack.enable = true;
        };
        displayManager.gdm = {
            debug = true;
            enable = false;
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

    programs = {
        hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
        };
        sway = {
            enable = true;
            xwayland.enable = true;

        };
        niri = {
            enable = true;
            package = pkgs.niri;
        };

        gamemode.enable = true;
        uwsm = {
            waylandCompositors = {
                sway = {
                    prettyName = "Sway";
                    comment = "Sway compositor managed by UWSM";
                    binPath = "${pkgs.sway}/bin/sway";

                };
            };
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
        steam = {
            enable = true;
            gamescopeSession.enable = true;
            remotePlay.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
            protontricks.enable = true;
            extraCompatPackages = with pkgs; [
                proton-ge-bin
            ];
        };

    };

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

    environment.systemPackages = with pkgs; [
        ani-cli
        app2unit # uwsm
        brightnessctl
        cliphist
        file-roller
        gdm-settings
        hyprpolkitagent
        hyprshot
        imv
        kdePackages.filelight
        kitty
        labwc # a very useful utility
        libnotify
        networkmanagerapplet
        nwg-displays
        nwg-hello
        nwg-icon-picker
        pamixer
        pavucontrol
        playerctl
        polkit_gnome
        pulseaudio # provides pactl
        vlc
        wev
        wine-wayland
        wl-clipboard
    ];

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
