{ config, lib, ... }:

let
  dotfilesPath = ../dotfiles;

  users = builtins.attrNames config.users.users;

  # pick first "normal" user (uid >= 1000)
  normalUsers =
    lib.filter (u: config.users.users.${u}.isNormalUser or false) users;

  user = lib.head normalUsers;

  entries =
    if builtins.pathExists dotfilesPath
    then builtins.readDir dotfilesPath
    else {};

  dirs =
    lib.filterAttrs (_: type: type == "directory") entries;

  links =
    lib.concatStringsSep "\n"
      (lib.mapAttrsToList (name: _:
        ''
          ln -sfn ${dotfilesPath}/${name} "$HOME/.config/${name}"
        ''
      ) dirs);

in
{
  config = lib.mkIf (normalUsers != []) {

    system.activationScripts.dotfiles = ''
      echo "[dotfiles] linking configs for ${user}"
      export HOME="/home/${user}"

      mkdir -p "$HOME/.config"

      ${links}
    '';
  };
}
