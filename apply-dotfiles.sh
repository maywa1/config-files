#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES="$REPO_ROOT/dotfiles"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p "$CONFIG"

for repo_path in "$DOTFILES"/*; do
  [ -e "$repo_path" ] || continue

  name="$(basename "$repo_path")"
  live_path="$CONFIG/$name"

  if [ -e "$live_path" ]; then
    # Pull the live config back into the repository.
    rm -rf "$repo_path"
    cp -a "$live_path" "$repo_path"
    echo "updated dotfiles: $name"
  else
    # Restore a missing config from the repository.
    cp -a "$repo_path" "$live_path"
    echo "restored config: $name"
  fi
done
