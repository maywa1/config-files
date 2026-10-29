{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;

    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
      "AUTO_CD"
      "CORRECT"
      "EXTENDED_GLOB"
    ];

    shellAliases = {
      ll = "ls -la --color=auto";
      update = "sudo nixos-rebuild switch --flake ~/nixos-conf#nixie";
    };

    initContent = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
      export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

      # VI keybindings
      bindkey -v
      export KEYTIMEOUT=1

      setopt PROMPT_SUBST
      PROMPT="%F{white}%n@%m%f %F{white}%~%f %# "
      RPROMPT="%F{white}[%D{%H:%M}]%f"
    '';
  };
}
