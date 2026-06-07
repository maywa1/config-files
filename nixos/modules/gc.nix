{ ... }:
{
    nix.gc.automatic = true;
    nix.gc.dates = "20:00";
    nix.gc.options = "--delete-older-than 3d";
}
