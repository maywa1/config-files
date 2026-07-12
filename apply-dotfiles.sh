#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/nixos-conf/dotfiles"
CONFIG="$HOME/.config"

mkdir -p "$CONFIG"

for dir in "$DOTFILES"/*; do
    [ -e "$dir" ] || continue

    name=$(basename "$dir")
    source="$CONFIG/$name"
    target="$DOTFILES/$name"

    if [ -e "$source" ]; then
        rm -rf "$target"
        cp -a "$source" "$target"
        echo "updated dotfiles: $name"
    else
        cp -a "$target" "$source"
        echo "restored config: $name"
    fi
done
