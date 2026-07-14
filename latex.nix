{ config, pkgs, ... } :
let
	tex = pkgs.texliveSmall.withPackages (
        ps: with ps; [

            scheme-medium
            mdwtools
            footmisc
            hyphenat
            changepage
            titling
            multirow
            # algorithmic
            lipsum
            ieeetran
	]);
in
{
    environment.systemPackages = with pkgs; [
        tex
    ];
}