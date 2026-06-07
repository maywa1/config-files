{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    # Enable command completion
    enableCompletion = true;

    # History settings
    histSize = 10000;

    setOptions = [
      "HIST_IGNORE_ALL_DUPS"  # ignore duplicate commands
      "AUTO_CD"               # cd by typing folder name
      "CORRECT"               # spell correction
      "EXTENDED_GLOB"         # advanced globbing
    ];

    # Vim keybindings
    keyBindings = "vi";

    # Aliases
    shellAliases = {
      ll = "ls -la --color=auto";
      update = "sudo nixos-rebuild switch";
    };

    # Prompt customization
    promptInit = ''
      setopt PROMPT_SUBST
      PROMPT="%F{magenta}%n@%m%f %F{white}%~%f %# "
      RPROMPT="%F{cyan}[%D{%H:%M}]%f"
    '';

    # Load autocomplete, syntax highlighting, autosuggestions
    interactiveShellInit = ''
      # Load zsh plugins installed system-wide
      if [ -f ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      fi
      if [ -f ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      fi
    '';
  };

  # Make sure the plugins are installed system-wide
  environment.systemPackages = with pkgs; [
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}
