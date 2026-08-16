{ pkgs, ... }:

{
  services.openssh.enable = true;

  services.udisks2.enable = true;

  services.displayManager.ly.enable = true;

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    libinput.naturalScrolling = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  systemd.user.services.udiskie = {
    description = "Automount removable drives with udiskie";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.udiskie}/bin/udiskie -t";
      Restart = "on-failure";
    };
  };
}
