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
    hyprlock
    hyprpaper
    inputs.helium.packages.${pkgs.system}.default
    lua-language-server
    lua51Packages.luarocks
    neovim
    nixd
    nodejs
    obsidian
    prettier
    pyright
    python3
    ripgrep
    rust-analyzer
    rustc
    tmux
    tree-sitter
    typescript-language-server
    udiskie
    universal-android-debloater
    uv
    vesktop
    vicinae
    vimPlugins.LazyVim
    waybar
    wget
    wl-clipboard
    zls
  ];
}
