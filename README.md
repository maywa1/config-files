Use the script to deploy changes easily:

```
$ ./deploy.sh <commit message>
```

This one is simalira to deploy but does not push the changes only commits
```
$ ./quick-update.sh <commit message>
```

Apply dotfiles takes the dotfiles from the $HOME/.config that have an equivalent in directory in ~/nix-conf/dotfiles/

```
$ ./apply-dotfiles.sh
```

