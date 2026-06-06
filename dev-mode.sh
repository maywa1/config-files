#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/nixos-conf/dotfiles"

mkdir -p "$HOME/.config"

for dir in "$DOTFILES"/*; do
    [ -d "$dir" ] || continue

    name=$(basename "$dir")

    rm -rf "$HOME/.config/$name"
    ln -s "$dir" "$HOME/.config/$name"

    echo "linked $name"
done
