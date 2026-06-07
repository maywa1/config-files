{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    udiskie
    hyprpaper
    tree-sitter
    brightnessctl
    neovim
    vimPlugins.LazyVim
    wget
    git
    alacritty
    btop
    fastfetch
    vesktop
    cargo
    rustc
    gcc
    python3
    nodejs
    tmux
    lua51Packages.luarocks
    inputs.zen-browser.packages.${pkgs.system}.default
    vicinae
    rust-analyzer
    lua-language-server
    zls
    pyright
    typescript-language-server
    emmet-language-server
    nixd
    alejandra
  ];
}
