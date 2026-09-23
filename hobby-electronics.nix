{ config, pkgs, lib, ... } : {

	hardware.rtl-sdr.enable = true;

	services.udev.extraRules = ''
		KERNEL=="ttyACM0", MODE:="666",
		KERNEL=="ttyUSB0", MODE:="666"

# MK22 radios (GD-77, DM-1801, RD-5R)
SUBSYSTEM=="usb", ATTR{idVendor}=="1fc9", ATTR{idProduct}=="0094", MODE="0666", GROUP="plugdev"

# STM32 radios (MD-UV380, MD-9600, DM-1701)
SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", MODE="0666", GROUP="plugdev"

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