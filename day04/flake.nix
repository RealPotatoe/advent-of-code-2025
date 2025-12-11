{
  description = "Advent of Code Day 04 - Haskell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        hpkgs = pkgs.haskellPackages;

        project = hpkgs.callCabal2nix "day04" ./. {};
      in {
        packages.default = project;

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.default;
        };

        devShells.default = hpkgs.shellFor {
          packages = p: [project];

          nativeBuildInputs = with hpkgs; [
            cabal-install
            haskell-language-server
            ormolu
            ghcid
          ];

          withHoogle = true;
        };
      }
    );
}
