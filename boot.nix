{ config, lib, pkgs, modulesPath, ... }: {
	boot = {
		kernelPackages = pkgs.linuxPackages_latest;

		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		plymouth = {
			enable = true;
		};
		consoleLogLevel = 3;
		initrd.verbose = false;
		kernelParams = [
			"quiet"
			"splash"
			"boot.shell_on_fail"
			"udev.log_priority=3"
			"rd.systemd.show_status=auto"
		];
		loader.timeout = 1;
		initrd.availableKernelModules = [
			"nvme"
			"xhci_pci"
			"thunderbolt"
			"usb_storage"
			"usbhid"
			"sd_mod"
		];
		initrd.kernelModules = [
		];
		kernelModules = [ "kvm-amd" ];
		extraModulePackages = [ ];
	};

	powerManagement.enable = true;



}