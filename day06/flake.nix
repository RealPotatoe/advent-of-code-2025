{
  description = "Advent of Code Day 06 - Kotlin";

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
        packages.default = pkgs.writeShellScriptBin "day06" ''
          export PATH="${pkgs.lib.makeBinPath [pkgs.kotlin pkgs.jdk pkgs.gnumake]}:$PATH"
          if [ -d "day06" ]; then
            cd day06
          fi
          trap "make clean" EXIT
          make run "$@"
        '';

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.default;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            kotlin
            jdk
            kotlin-language-server
            gnumake
          ];
        };
      }
    );
}
