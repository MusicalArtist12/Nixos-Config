{ config, lib, pkgs, modulesPath, ... }: {
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/056bd98a-6462-4b63-b6ed-c1118887369e";
			fsType = "ext4";
		};
		"/boot" = {
			device = "/dev/disk/by-uuid/9E6F-1D5F";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};
	};

	swapDevices = [
		{
			device = "/dev/disk/by-uuid/aa9cce3b-b4c8-4b18-813f-71c9395bb49c";
		}
	];

	networking = {
		hostName = "Hypatia"; # Define your hostname.
		networkmanager = {
			enable = true;
			wifi.powersave = true;
		};
		useDHCP = lib.mkDefault true;
	};

	hardware.bluetooth = {
		enable = true;
		settings.General.Enable = "Source,Sink,Media,Socket";
	};
	services.blueman.enable = true;


	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		loader = {
			systemd-boot.configurationLimit = 10;
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

	services.power-profiles-daemon.enable = true;

	services.logind.settings.Login = {
		HandleLidSwitch = "suspend-then-hibernate";
		HandlePowerKey = "hibernate";
		HandlePowerKeyLongPress = "poweroff";
	};

	systemd.services.fprintd = {
		wantedBy = [ "multi-user.target" ];
		serviceConfig.Type = "simple";
	};
	services.fprintd.enable = true;


	systemd.sleep.extraConfig = ''
		AllowSuspend=yes
		AllowHibernation=yes
		AllowHybridSleep=yes
		AllowSuspendThenHibernate=yes
		HibernateDelaySec=10m
		SuspendState=mem
		[Sleep]
		HibernateMode=shutdown
	'';

	powerManagement.enable = true;
}
