{ pkgs, inputs, ... }:
let
    hs = pkgs.haskellPackages;
in{

  environment.systemPackages = with pkgs; [
    alacritty
    alejandra
    bibata-cursors
    brightnessctl
    btop
    butterfly
    cabal-cli
    cargo
    dunst
    emmet-language-server
    fastfetch
    feh
    flameshot
    flameshot
    gcc
    git
    hs.cabal-install
    hs.ghc
    hs.haskell-language-server
    hs.hlint
    hs.hoogle
    hyprcursor
    inputs.helium.packages.${pkgs.system}.default
    libsForQt5.qtstyleplugin-kvantum
    lua-language-server
    lua51Packages.luarocks
    (neovim.override {
        extraPython3Packages = p: [ p.pynvim ];
    })
    nixd
    nodejs
    obsidian
    prettier
    prismlauncher
    pyright
    python3
    ripgrep
    rofi
    rust-analyzer
    rustc
    sioyek
    slock
    tmux
    tree-sitter
    typescript-language-server
    udiskie
    uv
    vesktop
    vimPlugins.LazyVim
    xclip
    xmobar
    zls
    ];
}
