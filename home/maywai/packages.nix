{
  pkgs,
  inputs,
  ...
}: let
  hs = pkgs.haskellPackages;
  helium = inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  # User-facing applications and development tools live in the Home Manager
  # profile. Only packages required by system services (setuid wrappers, the
  # X server, etc.) belong in environment.systemPackages.
  home.packages = with pkgs; [
    # Terminal and shell utilities
    alacritty
    btop
    fastfetch
    ripgrep
    tmux
    tree

    # Desktop applications
    butterfly
    dunst
    feh
    flameshot
    godot
    helium
    obsidian
    prismlauncher
    rofi
    sioyek
    vesktop
    xclip
    xmobar

    # Desktop integration
    brightnessctl
    gdtoolkit_4
    libsForQt5.qtstyleplugin-kvantum

    # Editors
    (neovim.override {
      withPython3 = true;
      extraPython3Packages = ps:
        with ps; [
          pynvim
        ];
    })
    vimPlugins.LazyVim

    # Language servers and formatters
    alejandra
    emmet-language-server
    lua-language-server
    nixd
    nodejs
    prettier
    pyright
    tree-sitter
    typescript-language-server
    zls

    # Rust
    cargo
    rust-analyzer
    rustc

    # Haskell
    hs.cabal-install
    hs.ghc
    hs.haskell-language-server
    hs.hlint
    hs.hoogle

    # Lua
    lua51Packages.luarocks

    # C/C++ and build tooling
    gcc
    pkg-config
    uv

    # Documents
    (texlive.withPackages (ps:
      with ps; [
        scheme-small
        latexmk
      ]))

    steam
  ];
}
