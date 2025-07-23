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

      specialArgs = { inherit inputs; };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      modules = [
        ./hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
