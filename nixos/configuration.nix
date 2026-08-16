{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/keyboard.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/programs.nix
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/services.nix
    ./modules/gc.nix
    ./modules/env.nix
    ./modules/zsh.nix
    ./modules/battery.nix
  ];
}
