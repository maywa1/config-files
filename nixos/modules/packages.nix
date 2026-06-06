{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    alacritty
    btop
    fastfetch
  ];
}
