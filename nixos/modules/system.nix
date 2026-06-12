{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    # Disable NVMe Autonomous Power State Transition (APST) to prevent the 31s SSD wake-up timeout
    "nvme_core.default_ps_max_latency_us=0"
    # Disable platform serial ports to prevent timeout on INT3515 phantom serial buses
    "8250.nr_uarts=0"

    "quiet"
    "splash"
    "loglevel=3"
  ];

  networking.hostName = "nixie";

  time.timeZone = "Europe/Lisbon";

  system.stateVersion = "26.05";
}
