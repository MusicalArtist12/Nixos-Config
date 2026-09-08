{ config, pkgs, lib, ... } : {

	hardware.rtl-sdr.enable = true;

	services.udev.extraRules = ''
		KERNEL=="ttyACM0", MODE:="666",
		KERNEL=="ttyUSB0", MODE:="666"
	'';

	environment.systemPackages = (with pkgs; [
		sdrangel
		sdrpp
		chirp
		vscode
		gimp
		blender
		godot
		openscad-unstable
	]);


}