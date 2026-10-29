{pkgs, ...}: {
  programs.dconf.enable = true;

  environment.systemPackages = [pkgs.dconf];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  environment.variables.GTK_THEME = "Adwaita:dark";

  systemd.user.services.set-dark-mode = {
    description = "Set system dark mode";
    wantedBy = ["default.target"];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
    '';
  };
}
