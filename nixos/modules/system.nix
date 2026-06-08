{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "quiet" "splash" "loglevel=3" ];
  boot.plymouth.enable = false;

  networking.hostName = "nixie";

  time.timeZone = "Europe/Lisbon";

  system.stateVersion = "26.05";
}
