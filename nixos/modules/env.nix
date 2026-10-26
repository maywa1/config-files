{ pkgs, ... }:
{
  environment.sessionVariables.PKG_CONFIG_PATH = [
    "/run/current-system/sw/lib/pkgconfig"
    "/run/current-system/sw/share/pkgconfig"
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";

    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_SIZE = "24";
  };
  xdg.icons = {
    enable = true;
  };

  environment.pathsToLink = [
    "/share/icons"
    "/lib/pkgconfig"
    "/share/pkgconfig"
  ];

}
