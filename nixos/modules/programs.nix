{pkgs, ...}: {
  programs.git.enable = true;

  programs.nix-ld.enable = true;

  security.wrappers.slock = {
    source = "${pkgs.slock}/bin/slock";
    owner = "root";
    group = "root";
    setuid = true;
  };
}
