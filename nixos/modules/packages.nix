{ pkgs, inputs, ... }:

let
  hs = pkgs.haskellPackages;

in
{
  environment.systemPackages = with pkgs; [
    godot
    gdtoolkit_4

    alacritty
    alejandra
    bibata-cursors
    brightnessctl
    btop
    butterfly
    cargo
    dunst
    emmet-language-server
    fastfetch
    feh
    flameshot
    gcc
    git
    hs.cabal-install
    hs.ghc
    hs.haskell-language-server
    hs.hlint
    hs.hoogle
    hyprcursor
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    libsForQt5.qtstyleplugin-kvantum
    lua-language-server
    lua51Packages.luarocks
    nixd
    nodejs
    obsidian
    prettier
    prismlauncher
    pyright
    ripgrep

    (neovim.override {
      withPython3 = true;
      extraPython3Packages = ps: with ps; [
        pynvim
      ];
    })

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

    (texlive.withPackages (ps: with ps; [
      scheme-small
      latexmk
    ]))

    # XMonad's runtime dependencies
    libx11
    libxrandr
    libxscrnsaver
    libxext
    libxinerama
    libxft
    libxcb

    # Flake dev-shell/build tooling
    pkg-config
  ];
}

