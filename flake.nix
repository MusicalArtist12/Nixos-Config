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
            nixpkgs-stable,
        }@inputs:
        let
            baseSystem =
                { extraSystemModules, extraHomeModules }:
                let
                    defaults = { pkgs, ... }: {
                        _module.args.pkgs-stable = import nixpkgs-stable {
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
                nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; };
                    modules = [
                        ./modules/all-pkgs-list.nix
                        ./modules/graphical.nix
                        ./modules/hobby-electronics.nix
                        ./modules/main.nix
                        ./modules/admin.nix
                        ./modules/dev.nix
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
                    ./hosts/dionysus/hardware.nix
                    nixos-hardware.nixosModules.common-cpu-amd
                    nixos-hardware.nixosModules.common-cpu-amd-zenpower
                ];
                extraHomeModules = [
                    ./hosts/dionysus/home-manager.nix
                ];
            };
            nixosConfigurations.Hypatia = baseSystem {
                extraSystemModules = [
                    ./hosts/hypatia/hardware.nix
                    nixos-hardware.nixosModules.framework-16-7040-amd
                    nixos-hardware.nixosModules.common-cpu-amd-zenpower
                ];
                extraHomeModules = [
                    ./hosts/hypatia/home-manager.nix
                ];
            };
        };
}
