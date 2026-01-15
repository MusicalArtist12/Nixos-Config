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
			url = "github:moonlight-mod/moonlight/main";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		catppuccin.url = "github:catppuccin/nix";
	};
    outputs = { nixpkgs, home-manager, nixos-hardware, catppuccin, ... } @ inputs: {

    }
}