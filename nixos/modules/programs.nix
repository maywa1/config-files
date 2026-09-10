{pkgs,  ... }:

{
    programs.dconf.enable = true;
    programs.git.enable = true;

    security.wrappers.slock = {
        source = "${pkgs.slock}/bin/slock";
        owner = "root";
        group = "root";
        setuid = true;
    };

}
