Use the script to deploy changes easily:

```
$ ./deploy.sh <commit message>
```

When developing you usually want to be able to see the changes you do so I added a dev mode script, which symlinks the ./dotfiles dir directly to your .config, but depending on the program like hyprland, you'll have to restart the environment for it to read the new symlink instead of the /nix/store one:

```
$ ./dev-mode.sh
```

