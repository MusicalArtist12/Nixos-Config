{ config, pkgs, ... }:
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
in
{
    environment.systemPackages = with pkgs; [
        pythonEnv
    ];
}
