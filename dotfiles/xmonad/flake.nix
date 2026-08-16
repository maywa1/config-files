{
  description = "xmonad configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      haskellPackages = pkgs.haskell.packages.ghc9103;

      x11Libs = [
        pkgs.libx11
        pkgs.libxrandr
        pkgs.libxscrnsaver
        pkgs.libxext
        pkgs.libxinerama
      ];

      xmonad-config = pkgs.haskell.lib.overrideCabal
        (haskellPackages.callCabal2nix "xmonad-config" ./. { })
        (old: {
          configureFlags = (old.configureFlags or []) ++ [
            "--extra-lib-dirs=${pkgs.lib.makeLibraryPath x11Libs}"
          ];
          librarySystemDepends = (old.librarySystemDepends or []) ++ x11Libs;
        });
    in
    {
      packages.${system}.default = xmonad-config;

      devShells.${system}.default = haskellPackages.shellFor {
        packages = p: [ xmonad-config ];

        buildInputs = [
          haskellPackages.cabal-install
          haskellPackages.ghc
        ];

        nativeBuildInputs = [
          pkgs.pkg-config
        ] ++ x11Libs;

        withHoogle = true;
      };
    };
}
