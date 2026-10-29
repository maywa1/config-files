{
  description = "NixOS configuration for nixie";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    username = "maywai";
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    # Exposed so `nix run .#home-manager -- switch ...` always uses the same
    # Home Manager version as the NixOS configuration.
    packages.${system}.home-manager = home-manager.packages.${system}.home-manager;

    # Standalone Home Manager configuration. It shares the same modules and
    # profile directory as the NixOS-embedded configuration, so a user-only
    # `home-manager switch` stays consistent with `nixos-rebuild switch`.
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      extraSpecialArgs = {inherit inputs;};

      modules = [
        ./home/maywai/home.nix
      ];
    };

    nixosConfigurations.nixie = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs system;
      };

      modules = [
        ./nixos/configuration.nix
      ];
    };
  };
}
