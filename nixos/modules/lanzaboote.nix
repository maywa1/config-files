{ pkgs, lib, ... }: {
    environment.systemPackages = [ pkgs.sbctl ]; # for debugging/enrolling keys

    boot.lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
    };

    # Lanzaboote replaces systemd-boot
    boot.loader.systemd-boot.enable = lib.mkForce false;
}

