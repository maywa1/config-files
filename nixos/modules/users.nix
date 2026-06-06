{ config, lib, pkgs, ... }:

{
  users.users.maywai = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };
}
