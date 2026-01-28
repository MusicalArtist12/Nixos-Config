{
	description = "base flake";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixos-hardware = {
			url = "github:NixOS/nixos-hardware/master";
			# inputs.nixpkgs.follows = "nixpkgs";
		};
		moonlight = {
			url = "github:moonlight-mod/moonlight/main";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		catppuccin = {
			url = "github:catppuccin/nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixpkgs-godot = {
			url = "github:NixOS/nixpkgs/master";
		};
		commit-mono-simple = {
			url = "path:/etc/nixos/pkg";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = { nixpkgs, home-manager, nixos-hardware, catppuccin, ... } @ inputs: {
		nixosConfigurations.Dionysus = nixpkgs.lib.nixosSystem {

			specialArgs = { inherit inputs; };
			modules = [
				./main.nix
				./graphical.nix
				./hardware-config/dionysus.nix
				./latex.nix
				./python.nix
				home-manager.nixosModules.home-manager
				catppuccin.nixosModules.catppuccin
				nixos-hardware.nixosModules.common-cpu-amd
				nixos-hardware.nixosModules.common-cpu-amd-zenpower
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.julia = {
						imports = [
							./home-manager/julia.nix
							./home-manager/machines/dionysus.nix
							catppuccin.homeModules.catppuccin
						];
					};
					home-manager.extraSpecialArgs = { inherit inputs; };
				}
			];
		};
		nixosConfigurations.Hypatia = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./main.nix
				./hardware-config/hypatia.nix
				./graphical.nix
				./python.nix
				./latex.nix
				nixos-hardware.nixosModules.framework-16-7040-amd
				home-manager.nixosModules.home-manager
				catppuccin.nixosModules.catppuccin
				nixos-hardware.nixosModules.common-cpu-amd-zenpower
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.julia = {
						imports = [
							./home-manager/julia.nix
							./home-manager/machines/hypatia.nix
							catppuccin.homeModules.catppuccin
						];
					};
					home-manager.extraSpecialArgs = { inherit inputs; };
				}


			];
		};
	};
}
