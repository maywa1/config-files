{pkgs, ...}: {
  users.users.maywai = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video"];
  };

  users.defaultUserShell = pkgs.zsh;
}
