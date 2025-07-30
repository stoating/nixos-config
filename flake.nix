{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    cfg = import ./hosts/devbox/_devbox.nix;
    system = cfg.system;
  in
  {
    nixosConfigurations.devbox = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/devbox/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
