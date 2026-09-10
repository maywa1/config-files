{ ... }:
{
    environment.etc."xdg/qt5ct/qt5ct.conf".text = ''
        [Appearance]
        style=Fusion
        color_scheme_path=/etc/xdg/qt5ct/colors/darker.conf
        custom_palette=true
    '';
    environment.sessionVariables = {
        GTK_THEME = "Adwaita:dark";
        QT_QPA_PLATFORMTHEME = "qt5ct";
        ELECTRON_FORCE_DARK_MODE = "1";
    };

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
    ];

}
