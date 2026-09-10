{ pkgs, ...}: {
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    dconf
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.variables.GTK_THEME = "Adwaita:dark";

  systemd.user.services.set-dark-mode = {
    description = "Set system dark mode";
    wantedBy = [ "default.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
    '';
  };
}

