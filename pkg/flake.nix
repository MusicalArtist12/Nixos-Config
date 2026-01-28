{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    outputs = { self, nixpkgs }:
    let
        inherit (nixpkgs) lib;
        forAllSystems = lib.genAttrs systems;
        systems = [
            "x86_64-linux"
        ];
    in {
        packages = forAllSystems (system: {
            commit-mono-simple = nixpkgs.legacyPackages.${system}.callPackage ./package.nix { };
            default = self.packages.${system}.commit-mono-simple;
        });
    };
}
