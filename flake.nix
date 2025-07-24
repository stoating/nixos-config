{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
      ];

      pkgs = import nixpkgs {
        inherit system;
      };

      specialArgs = { inherit inputs; };
    };
  };
}
