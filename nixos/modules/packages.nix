{pkgs, ...}: {
  # XMonad links against these libraries at runtime, and the custom config in
  # dotfiles/xmonad needs their headers when it is rebuilt. The window manager
  # is a system service, so its native dependencies stay system-wide. Everything
  # installed for day-to-day use lives in home/maywai/packages.nix.
  environment.systemPackages = with pkgs; [
    # Cursor theme referenced by environment.sessionVariables.
    bibata-cursors

    libx11
    libx11.dev
    libxcb
    libxcb.dev
    libxext
    libxext.dev
    libxft
    libxinerama
    libxinerama.dev
    libxrandr
    libxrandr.dev
    libxscrnsaver
  ];
}
