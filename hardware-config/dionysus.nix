{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
        ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/1e28f119-f517-456d-8d44-6dcea37acc04";
        fsType = "ext4";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/8F28-7235";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices =
    [
        { device = "/dev/disk/by-uuid/0a6bc297-3f2c-491d-a230-5a4e1ddb235c"; }
    ];


    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    networking = {
        hostName = "Dionysus";
        networkmanager = {
        enable = true;
        };
        useDHCP = lib.mkDefault true;
    };
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        plymouth = {
			enable = true;
			# theme = "script";
			logo = ../lix-snowflake.png;
		};
        initrd.verbose = false;
		kernelParams = [
			"quiet"
			"boot.shell_on_fail"
			"udev.log_priority=3"
			"rd.systemd.show_status=auto"

		];
    };

    hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
}
