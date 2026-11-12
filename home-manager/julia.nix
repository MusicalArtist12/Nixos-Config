# { config, pkgs, catppuccin, inputs, lib, pkgs-stable, ... }:
{ config, pkgs, inputs, ... }:
let
    theme = (import ./theme.nix);

    music_apps = with pkgs; [
        supercollider
        bitwig-studio
        musescore
    ];
    maker_apps = with pkgs; [
        inkscape
        gimp
        blender
        prusa-slicer
    ];
    moonlightDiscord = pkgs.discord.override {
        withMoonlight = true;
        moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
    };
    office_apps = with pkgs; [
        foliate # ebook reader in gtk flavor
        libreoffice
        obsidian
    ];
    environment_apps = with pkgs; [
        pokemon-colorscripts
        hyprshot
    ];
    app_groups = music_apps ++ maker_apps ++ office_apps ++ environment_apps;
in
{
    home.username = "julia";
    home.homeDirectory = "/home/julia";
    home.stateVersion = "25.05"; # no touchy

    programs = {
        kitty = {
            enable = true;
            enableGitIntegration = true;
            font = {
                name = "JetBrains Mono Nerd Font";
                size = theme.font_size;
            };
            settings = {
                confirm_os_window_close = 0;
            };
            shellIntegration.enableZshIntegration = true;
            themeFile = "Catppuccin-Mocha";
        };
        git = {
            enable = true;
            settings.user = {
                name = "MusicalArtist12";
                email = "TheMusicalArtist12@gmail.com";
            };
            lfs.enable = true;
        };
        firefox = {
            enable = true;
        };
    };

    home.file.celeste-background = {
        source = ./celeste.png;
        target = "Pictures/Backgrounds/celeste.png";
    };

    home.packages = with pkgs; [
        ani-cli
        piper
        qemu
        tmux

        moonlightDiscord
        spotify
    ] ++ app_groups;

    imports = [
        ./eww
        ./fetch
        ./hyprpicker
        ./niri
        ./power
        ./rofi
        ./theming.nix
        ./tools
        ./vim
        ./zsh
        ./mako
    ];

    home.sessionPath = [ "/home/julia/.local/bin" ];
    programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
}
