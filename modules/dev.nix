{ pkgs, ... }:
let
    python-with-packages = pkgs.python3.withPackages (
        p: with p; [
            ipykernel
            ipython
            jupyter
            matplotlib
            notebook
            numpy
            numpy
            opencv-python
            pygobject3 # req. for gimp plugins written in python
            regex
        ]
    );
    latex-with-packages = pkgs.texliveSmall.withPackages (
        ps: with ps; [
            # algorithmic
            changepage
            footmisc
            hyphenat
            ieeetran
            lipsum
            mdwtools
            multirow
            scheme-medium
            titling
        ]
    );

    c-dev = with pkgs; [
        bison
        clang
        cmake
        gnumake
    ];
    game-dev = with pkgs; [
        godot
    ];
    dev-general = with pkgs; [
        gh
        git
        jq # json parsing
        nodejs
        wget
        vscode
        ruby
        python-with-packages
        latex-with-packages
    ];
    uncategorized-dev-apps = with pkgs; [
        openscad-unstable
    ];
in
{
    environment.systemPackages = builtins.concatLists [
        c-dev
        game-dev
        uncategorized-dev-apps
        dev-general
    ];

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        fontconfig
        libcxx
        libX11
        stdenv.cc.cc
        wayland
    ];
    programs.zsh.enable = true;
    environment.pathsToLink = [ "/share/zsh" ];

}
