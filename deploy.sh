#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
HOST="$(hostname -s)"
COMMIT_MSG="${1:-BAM!}"

cd "$REPO_ROOT"

echo "==> Applying dotfiles from $HOME/.config"
./apply-dotfiles.sh

echo "==> Updating flake inputs"
nix flake update

echo "==> Rebuilding NixOS for host: $HOST"
sudo nixos-rebuild switch --flake "$REPO_ROOT#$HOST"

echo "==> Staging changes"
git add -A

echo "==> Committing"
if git diff --cached --quiet; then
  echo "No changes to commit."
else
  git commit -m "$COMMIT_MSG"
fi

echo "==> Pushing"
BRANCH="$(git branch --show-current)"
git push --set-upstream origin "$BRANCH"

echo "Done."
