{ config, lib, pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };
}
