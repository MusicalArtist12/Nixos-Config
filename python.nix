{ config, pkgs, ... } :
let
	pythonEnv = pkgs.python3.withPackages (p: with p; [
			numpy
			regex
			opencv-python
			matplotlib
			numpy
			ipykernel
			jupyter
			ipython
			notebook
		]);
in
{
    environment.systemPackages = with pkgs; [
        pythonEnv
    ];
}