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
		# vim
		wget
		git

		gnumake
		cmake
		bison
		clang

		killall
		bat
		jq

		fzf

		unzip

		pciutils
		usbutils
		gh

		nodejs

		tty-clock
	]);
	environment.pathsToLink = [ "/share/zsh" ];

	services.upower.enable = true;
	programs.zsh.enable = true;
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		libcxx
		stdenv.cc.cc
		fontconfig
		wayland
		libX11
	];

	systemd.tmpfiles.settings."10-nixos-directory"."/etc/nixos".d = {
		user = "root";
		group = "nixos";
		mode = "0775";
	};



	services.udev.extraRules = ''
		KERNEL=="ttyACM0", MODE:="666"
	'';
}
