{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    histSize = 10000;

    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
      "AUTO_CD"
      "CORRECT"
      "EXTENDED_GLOB"
    ];

    shellAliases = {
      ll = "ls -la --color=auto";
      update = "sudo nixos-rebuild switch";
    };

    # Prompt (clean monochrome + pastel pink user@host)
    promptInit = ''
      setopt PROMPT_SUBST
      PROMPT="%F{magenta}%n@%m%f %F{white}%~%f %# "
      RPROMPT="%F{cyan}[%D{%H:%M}]%f"
    '';

    # vi mode + plugins
    interactiveShellInit = ''
      # VI keybindings (this replaces keyBindings option)
      bindkey -v

      # Optional nicer vi mode cursor behavior
      export KEYTIMEOUT=1

      # Autosuggestions
      if [ -f ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      fi

      # Syntax highlighting (must be last)
      if [ -f ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      fi
    '';
  };

  # Required packages (system-wide)
  environment.systemPackages = with pkgs; [
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}
