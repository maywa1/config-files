{ pkgs, ... }:

{
  users.users.maywai = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };
  users.defaultUserShell = pkgs.zsh;
  system.userActivationScripts.zshrc = "touch .zshrc";
}
