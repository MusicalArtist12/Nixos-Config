{ config, lib, pkgs, modulesPath, ... }: {
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	fileSystems."/" = {
		device = "/dev/disk/by-uuid/056bd98a-6462-4b63-b6ed-c1118887369e";
		fsType = "ext4";
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-uuid/9E6F-1D5F";
		fsType = "vfat";
		options = [ "fmask=0077" "dmask=0077" ];
	};

	swapDevices = [
		{
			device = "/dev/disk/by-uuid/aa9cce3b-b4c8-4b18-813f-71c9395bb49c";
		}
	];

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
