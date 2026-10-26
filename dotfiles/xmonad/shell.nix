{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [
    ghc
    cabal-install
    pkg-config
    xorg.libX11
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXext
    xorg.libXScrnSaver
    xorg.libXft
  ];
}
