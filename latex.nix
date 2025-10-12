{ config, pkgs, ... } :
let
	tex = (pkgs.texlive.combine {
		inherit (pkgs.texlive)
            scheme-medium
            mdwtools
            footmisc
            hyphenat
            changepage
            titling
            lipsum;
	});
in
{
    environment.systemPackages = with pkgs; [
        tex
    ];
}