{
	description = "base flake";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixos-hardware.url = "github:NixOs/nixos-hardware/master";
		moonlight = {
			url = "github:moonlight-mod/moonlight";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = { nixpkgs, home-manager, nixos-hardware, ... } @ inputs: {
		nixosConfigurations.Hypatia = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				./hardware-configuration.nix
				./graphical.nix
				./services.nix
				./boot.nix
				./latex.nix
				nixos-hardware.nixosModules.framework-16-7040-amd
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.julia = ./home.nix;
				}
				./hyprland/default.nix

			];
		};
	};
}
