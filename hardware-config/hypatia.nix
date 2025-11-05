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
			systemd-boot.consoleMode = "0";
			efi.canTouchEfiVariables = true;
		};
		plymouth = {
			enable = true;
			# theme = "script";
			#logo = "${pkgs.nixos-icons}/share/icons/hicolor/256x256/apps/nix-snowflake.png";
			logo = ../lix-snowflake.png;
		};
		consoleLogLevel = 3;
		initrd.verbose = false;
		kernelParams = [
			"quiet"
			"boot.shell_on_fail"
			"udev.log_priority=3"
			"rd.systemd.show_status=auto"
			"amdgpu.abmlevel=0"
		];
		loader.timeout = 0;
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
		HandlePowerKey = "hibernate";
		HandlePowerKeyLongPress = "poweroff";
		HandleSuspendKey = "ignore";
		HandleLidSwitch = "ignore";
		HandleLidSwitchExternalPower = "ignore";
		HandleLidSwitchDocked = "ignore";
	};

	systemd.services.fprintd = {
		wantedBy = [ "multi-user.target" ];
		serviceConfig.Type = "simple";
	};
	services.fprintd.enable = true;

	services.fwupd.enable = true;

	systemd.sleep.extraConfig = ''
		AllowSuspend=yes
		AllowHibernation=yes
		AllowHybridSleep=yes
		AllowSuspendThenHibernate=yes
		HibernateDelaySec=10m
		SuspendState=mem
		HibernateDelaySec=1800
		MemorySleepMode=s2idle
		[Sleep]
		HibernateMode=shutdown
	'';

	services.udev.extraRules = ''
		SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0012", ATTR{power/wakeup}="disabled", ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
		SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0014", ATTR{power/wakeup}="disabled", ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
	'';

	hardware.keyboard.qmk.enable = true;

	powerManagement.enable = true;
}
