{ config, lib, pkgs, modulesPath, ... }:

{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ "nvidia" ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [  ];

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/1e28f119-f517-456d-8d44-6dcea37acc04";
        fsType = "ext4";
    };
    fileSystems."/sn850x" = {
        device = "/dev/disk/by-uuid/802eebf4-8082-4956-968b-800896602cd6";
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
        kernelPackages = pkgs.linuxPackages;
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        plymouth = {
			enable = true;
			# theme = "script";
			logo = ../res/lix-snowflake.png;
		};
        initrd.verbose = false;
		kernelParams = [
			"quiet"
			"boot.shell_on_fail"
			"udev.log_priority=3"
			"rd.systemd.show_status=auto"
		];
    };

    boot.blacklistedKernelModules = [ "nouveau" ];

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
	    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
            version = "575.64.05";
            sha256_64bit = "sha256-hfK1D5EiYcGRegss9+H5dDr/0Aj9wPIJ9NVWP3dNUC0=";
            sha256_aarch64 = "sha256-GRE9VEEosbY7TL4HPFoyo0Ac5jgBHsZg9sBKJ4BLhsA=";
            openSha256 = "sha256-mcbMVEyRxNyRrohgwWNylu45vIqF+flKHnmt47R//KU=";
            settingsSha256 = "sha256-o2zUnYFUQjHOcCrB0w/4L6xI1hVUXLAWgG2Y26BowBE=";
            persistencedSha256 = "sha256-2g5z7Pu8u2EiAh5givP5Q1Y4zk4Cbb06W37rf768NFU=";
        };
        forceFullCompositionPipeline = true;

    };

    programs.coolercontrol = {
        enable = true;

    };
    environment.systemPackages = (with pkgs; [
        liquidctl
        lm_sensors
        openrgb-with-all-plugins
        lact
        qemu
        prusa-slicer
        pkg-config # need for mkDriver?
    ]);

    virtualisation.libvirtd.enable = true;
    users.users.julia.extraGroups = [ "libvirtd" ];
    programs.virt-manager.enable = true;

    services.lact.enable = true;

    hardware.bluetooth = {
		enable = true;
		settings.General.Enable = "Source,Sink,Media,Socket";
	};
	services.blueman.enable = true;


    services.hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
    };

    programs.sway.extraOptions = [
        "--unsupported-gpu"
    ];
    programs.uwsm.waylandCompositors.sway.extraArgs = [
        "--unsupported-gpu"
    ];

    # security.pam.loginLimits = [
    #     { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
    # ];

    environment.sessionVariables = {
        MAKEOPTS = "-j8";
        MAKEFLAGS = "-j8";
    };

    nix.settings = {
        substituters = [
            "https://cache.nixos-cuda.org"
        ];
        trusted-public-keys = [
            "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        ];
    };

    programs.steam = let
        patchedBwrap = pkgs.bubblewrap.overrideAttrs (o: {
            patches = (o.patches or []) ++ [
            ./bwrap.patch
            ];
        });
    in {
        enable = true;
        package = pkgs.steam.override {
            buildFHSEnv = (args: ((pkgs.buildFHSEnv.override {
                bubblewrap = patchedBwrap;
            }) (args // {
                extraBwrapArgs = (args.extraBwrapArgs or []) ++ [ "--cap-add ALL" ];
            })));
        };
    };

}
