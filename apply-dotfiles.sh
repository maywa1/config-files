#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/nixos-conf/dotfiles"
CONFIG="$HOME/.config"

for dir in "$DOTFILES"/*; do
    [ -e "$dir" ] || continue

    name=$(basename "$dir")

    [ -e "$CONFIG/$name" ] || continue

    rm -rf "$DOTFILES/$name"
    cp -a "$CONFIG/$name" "$DOTFILES/$name"

    echo "copied $name"
done
