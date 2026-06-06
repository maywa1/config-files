{ config, lib, pkgs, ... }:

{
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.xkb = {
    layout = "br";
    variant = "dvorak";
    options = "eurosign:e,caps:escape";
  };
}
