{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    day01.url = "path:./day01";
    day01.inputs.nixpkgs.follows = "nixpkgs";

    day02.url = "path:./day02";
    day02.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    apps = forAllSystems (system: {
      day01 = inputs.day01.apps.${system}.default;
      day02 = inputs.day02.apps.${system}.default;
    });
  };
}