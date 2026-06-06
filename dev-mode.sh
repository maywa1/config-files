#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/nix-config/dotfiles"

mkdir -p "$HOME/.config"

for dir in "$DOTFILES"/*; do
    [ -d "$dir" ] || continue

    name=$(basename "$dir")

    ln -sfn "$dir" "$HOME/.config/$name"
    echo "linked $name"
done
