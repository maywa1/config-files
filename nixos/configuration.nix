{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/dotfiles.nix
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/keyboard.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/programs.nix
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/services.nix
    ./modules/greetd.nix
  ];
}
