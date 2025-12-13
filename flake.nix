{
  description = "Advent of Code 2025";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    day01.url = "path:./day01";
    day01.inputs.nixpkgs.follows = "nixpkgs";

    day02.url = "path:./day02";
    day02.inputs.nixpkgs.follows = "nixpkgs";

    day03.url = "path:./day03";
    day03.inputs.nixpkgs.follows = "nixpkgs";

    day04.url = "path:./day04";
    day04.inputs.nixpkgs.follows = "nixpkgs";

    day05.url = "path:./day05";
    day05.inputs.nixpkgs.follows = "nixpkgs";

    day06.url = "path:./day06";
    day06.inputs.nixpkgs.follows = "nixpkgs";
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
          day03 = inputs.day03.apps.${system}.default;
          day04 = inputs.day04.apps.${system}.default;
          day05 = inputs.day05.apps.${system}.default;
          day06 = inputs.day06.apps.${system}.default;
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
