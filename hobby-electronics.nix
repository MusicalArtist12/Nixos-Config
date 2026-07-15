{ config, pkgs, lib, ... } : {

	hardware.rtl-sdr.enable = true;

	services.udev.extraRules = ''
KERNEL=="ttyACM0", MODE:="666"
	'';

	environment.systemPackages = (with pkgs; [
		sdrangel
		chirp
		vscode
		gimp
		blender
		godot
		openscad-unstable
	]);


}