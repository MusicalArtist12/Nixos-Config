{ config, pkgs, ... }:
let
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
in
{
    environment.systemPackages = with pkgs; [
        tex
    ];
}
