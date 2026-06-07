{}: let
in {
    nix.gc.automatic = true;
    nix.gc.date = "20:00";
    nix.gc.options = "--delete-older-than 3d";
}
