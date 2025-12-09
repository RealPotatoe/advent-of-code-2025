{
  description = "Advent of Code 2025";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    day01.url = "path:./day01";
    day01.inputs.nixpkgs.follows = "nixpkgs";

    day02.url = "path:./day02";
    day02.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        apps = {
          day01 = inputs.day01.apps.${system}.default;
          day02 = inputs.day02.apps.${system}.default;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nil
            alejandra
          ];
        };
      }
    );
}
