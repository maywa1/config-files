{
  description = "xmonad configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = import ./default.nix { inherit pkgs; };

      devShells.${system}.default = pkgs.haskell.packages.ghc9103.shellFor {
        packages = p: [ (import ./default.nix { inherit pkgs; }) ];
        buildInputs = with pkgs.haskell.packages.ghc9103; [ cabal-install ghc ];
        nativeBuildInputs = [ pkgs.pkg-config ] ++ (import ./default.nix { inherit pkgs; }).librarySystemDepends or [];
        withHoogle = true;
      };
    };
}
