{ pkgs, ... }:
let
    pythonEnv = pkgs.python3.withPackages (
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
    tex = pkgs.texliveSmall.withPackages (
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

    c_dev = with pkgs; [
        bison
        clang
        cmake
        gnumake
    ];
    game_dev = with pkgs; [

        godot
    ];
    app_groups = c_dev ++ game_dev;
in
{
    environment.systemPackages = (
        with pkgs;
        [
            gh
            git

            jq # json parsing
            nodejs
            wget
            vscode
            ruby

            openscad-unstable

            pythonEnv
            tex
        ] ++ app_groups
    );

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
