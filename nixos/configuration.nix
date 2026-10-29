{...}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix

    ./modules/battery.nix
    ./modules/dark_mode.nix
    ./modules/env.nix
    ./modules/fonts.nix
    ./modules/gc.nix
    ./modules/home-manager.nix
    ./modules/keyboard.nix
    ./modules/lanzaboote.nix
    ./modules/networking.nix
    ./modules/packages.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/system.nix
    ./modules/users.nix
    ./modules/zsh.nix
  ];
}
