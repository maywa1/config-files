{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    git
    alacritty
    btop
    fastfetch
    vencord
  ];
}
