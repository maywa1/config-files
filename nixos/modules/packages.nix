{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    vimPlugins.LazyVim
    wget
    git
    alacritty
    btop
    fastfetch
    vesktop
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}
