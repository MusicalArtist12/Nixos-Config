{ config, pkgs, lib, ... } : {

	system.stateVersion = "25.05"; # no touchy - at all
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
		extraGroups = [ "networkmanager" "wheel" "nixos" "video" ];
		packages = with pkgs; [];
		shell = pkgs.zsh;
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = (with pkgs; [
		vim
		wget
		git
		python313
		gnumake
		cmake
		clang
		killall
		bat
		jq

		fzf-zsh
		fzf

		unzip

		brightnessctl

		pciutils
		usbutils
		lm_sensors
		gh

		qmk

		nodejs
	]) ++ (with pkgs.python313Packages; [
		# Deep Learning
        scipy
        numpy
        matplotlib
        pandas
        statsmodels
        scikit-learn
        ipykernel
        jupyter
        ipython
        notebook
    ]);

	services.upower.enable = true;

	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
	};



}
