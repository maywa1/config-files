#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
USER_NAME="maywai"

cd "$REPO_ROOT"

echo "==> Updating flake inputs"
nix flake update

echo "==> Switching Home Manager configuration for: $USER_NAME"
nix run "$REPO_ROOT#home-manager" -- switch -b backup --flake "$REPO_ROOT#$USER_NAME"

echo "Done. The system configuration was not rebuilt."
