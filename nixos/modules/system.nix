{pkgs, ...}: {
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
  ];

  # Work around mt7921e ASPM issues on this laptop.
  boot.extraModprobeConfig = ''
    options mt7921e disable_aspm=1
  '';

  networking.hostName = "nixie";
  time.timeZone = "Europe/Lisbon";

  system.stateVersion = "26.05";
}
