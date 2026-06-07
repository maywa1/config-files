#!/usr/bin/env bash
set -euo pipefail

# Optional commit message argument
COMMIT_MSG="${1:-Quick update, like new package}"
HOSTNAME="$(hostname)"

echo "Updating flake inputs..."
nix flake update

echo "Staging changes..."
git add .

echo "Committing..."
git commit -m "$COMMIT_MSG" || echo "No changes to commit."

echo "Rebuilding NixOS for host: $HOSTNAME"
sudo nixos-rebuild switch --flake ".#$HOSTNAME"

./dev-mode.sh
