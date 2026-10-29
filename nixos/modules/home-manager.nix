{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;

    # Keep Home Manager's profile as the regular user profile instead of
    # /etc/profiles/per-user/maywai. This makes `home-manager switch` and
    # `nixos-rebuild switch` manage the exact same profile, so updating only
    # the user environment is safe.
    useUserPackages = false;

    # Move pre-existing files out of the way instead of failing activation.
    backupFileExtension = "backup";

    extraSpecialArgs = {inherit inputs;};
    users.maywai = import ../../home/maywai/home.nix;
  };
}
