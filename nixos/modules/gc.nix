{...}: {
  nix.gc = {
    automatic = true;
    dates = "20:00";
    options = "--delete-older-than 3d";
  };
}
