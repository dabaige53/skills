#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE="$REPO/.codex/agents"
DEST="${CODEX_HOME:-$HOME/.codex}/agents"

mkdir -p "$DEST"

for src in "$SOURCE"/*.toml; do
  name="$(basename "$src")"
  target="$DEST/$name"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "error: refusing to replace existing agent file: $target" >&2
    exit 1
  fi

  ln -sfn "$src" "$target"
  echo "linked $name -> $src"
done

echo "Restart Codex or start a new task to load the agent profiles."
