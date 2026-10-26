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
        };
        moonlight = {
            url = "github:moonlight-mod/moonlight/main";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixpkgs-stable = {
            url = "github:NixOS/nixpkgs/nixos-25.11";
        };
        #pkgs-internal = {
        #	url = "path:/etc/nixos/pkg";
        #	inputs.nixpkgs.follows = "nixpkgs";
        #};
        niri-flake = {
            url = "github:sodiboo/niri-flake/main";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs =
        {
            self,
            nixpkgs,
            home-manager,
            nixos-hardware,
            niri-flake,
            ...
        }@inputs:
        let
            baseSystem =
                { extraSystemModules, extraHomeModules }:
                let
                    defaults = { pkgs, ... }: {
                        _module.args.pkgs-stable = import inputs.nixpkgs-stable {
                            inherit (pkgs.stdenv.targetPlatform) system;
                        };
                    };
                    homeManagerModule = {
                        home-manager = {
                            extraSpecialArgs = { inherit inputs; };
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users.julia = {
                                imports = [
                                    defaults
                                    ./home-manager/julia.nix
                                ]
                                ++ extraHomeModules;
                            };
                        };
                    };
                in
                nixpkgs.lib.nixosSystem rec {

                    modules = [
                        ./all-pkgs-list.nix
                        ./graphical.nix
                        ./hobby-electronics.nix
                        ./latex.nix
                        ./main.nix
                        ./python.nix
                        home-manager.nixosModules.home-manager
                        homeManagerModule
                        niri-flake.nixosModules.niri
                    ]
                    ++ extraSystemModules;
                };
        in
        {
            nixosConfigurations.Dionysus = baseSystem {
                extraSystemModules = [
                    ./hardware-config/dionysus.nix
                    nixos-hardware.nixosModules.common-cpu-amd
                    nixos-hardware.nixosModules.common-cpu-amd-zenpower
                ];
                extraHomeModules = [
                    ./home-manager/machines/dionysus.nix
                ];
            };
            nixosConfigurations.Hypatia = baseSystem {
                extraSystemModules = [
                    ./hardware-config/hypatia.nix
                    nixos-hardware.nixosModules.framework-16-7040-amd
                    nixos-hardware.nixosModules.common-cpu-amd-zenpower
                ];
                extraHomeModules = [
                    ./home-manager/machines/hypatia.nix
                ];
            };
        };
}
