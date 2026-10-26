# { config, pkgs, catppuccin, inputs, lib, pkgs-stable, ... }:
{
    config,
    pkgs,
    inputs,
    lib,
    pkgs-stable,
    ...
}:
let
    theme = (import ./theme.nix);
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
                #name = "CommitMonoSimple";
                #size = theme.font_size;
                # package = inputs.pkgs-internal.packages.${pkgs.system}.commit-mono-simple;
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

    home.packages =
        let
            moonlightDiscord = pkgs.discord.override {
                withMoonlight = true;
                moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
            };
        in
        (with pkgs; [
            # bitwarden-desktop
            # musescore
            bitwig-studio
            foliate # ebook reader in gtk flavor
            inkscape
            libreoffice
            moonlightDiscord
            obsidian
            olympus
            pokemon-colorscripts
            prismlauncher
            ruby
            spotify
            supercollider
            tmux
        ]);

    imports = [
        ./eww
        ./fetch
        ./hyprland/hyprpicker
        ./niri
        ./power
        ./rofi
        ./sway
        ./swaync
        ./theming.nix
        ./tools
        ./vim
        ./zsh
    ];

    home.sessionPath = [ "/home/julia/.local/bin" ];
    programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
}
