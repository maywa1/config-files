{ pkgs, ... }:

{
  services.openssh.enable = true;

  services.udisks2.enable = true;

  systemd.user.services.udiskie = {
    description = "Automount removable drives with udiskie";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.udiskie}/bin/udiskie -t";
      Restart = "on-failure";
    };
  };
}
