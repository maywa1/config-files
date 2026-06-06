{
  description = "nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixie = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit system inputs;
        };

        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
