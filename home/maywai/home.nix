{
  imports = [
    ./packages.nix
    ./zsh.nix
  ];

  home = {
    username = "maywai";
    homeDirectory = "/home/maywai";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
