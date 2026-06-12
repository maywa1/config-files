{ pkgs, inputs, ... }:

{

  environment.systemPackages = with pkgs; [
    alacritty
    alejandra
    bibata-cursors
    brightnessctl
    btop
    cargo
    emmet-language-server
    fastfetch
    gcc
    git
    hyprcursor
    hyprpaper
    inputs.helium.packages.${pkgs.system}.default
    inputs.zen-browser.packages.${pkgs.system}.default
    lua-language-server
    lua51Packages.luarocks
    neovim
    nixd
    nodejs
    obsidian
    pyright
    python3
    rust-analyzer
    rustc
    tmux
    tree-sitter
    typescript-language-server
    udiskie
    vesktop
    vicinae
    vimPlugins.LazyVim
    wget
    zls
  ];
}
