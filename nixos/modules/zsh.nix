{...}: {
  # Enable zsh as a system login shell. The actual user configuration
  # (aliases, prompt, plugins) lives in home/maywai/zsh.nix.
  programs.zsh.enable = true;
}
