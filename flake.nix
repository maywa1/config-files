{
  description = "nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixie = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system;};
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
