{
  description = "Advent of Code Day 01 - Python";

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
      in {
        packages.default = pkgs.writeShellScriptBin "day01" ''
          ${pkgs.python3}/bin/python3 ${./main.py} "$@"
        '';

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.default;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nil
            alejandra
            python3
            python3Packages.black
            python3Packages.python-lsp-server
          ];
        };
      }
    );
}
