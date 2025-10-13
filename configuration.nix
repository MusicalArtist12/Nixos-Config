{ config, pkgs, lib, ... } : {

	system.stateVersion = "25.05"; # no touchy - at all
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

	# Set your time zone.
	time.timeZone = "America/Los_Angeles";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Group to modify /etc/nix files
	users.groups.nixos = {};

	users.users.julia = {
		isNormalUser = true;
		description = "julia";
		extraGroups = [ "networkmanager" "wheel" "nixos" ];
		packages = with pkgs; [];
		shell = pkgs.zsh;
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		vim
		wget
		ranger
		fastfetch
		git
		python314
		gnumake
		cmake
		clang
		killall
		bat

		fzf-zsh
		fzf

		unzip

		brightnessctl
		pciutils
		usbutils
		lm_sensors
		gh
	];
	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
	};


}
