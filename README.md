
How do you run this thing? Updating/upgrading looks something like this (should look familiar):

- Make edits to the configuration.nix in your repo (e.g. to add a new package)
- nix flake update <- if you want to pull more recent versions of things
- git commit -a -m "BAM!" && git push
- sudo nixos-rebuild switch --flake .#your-hostname


