#!/bin/bash
# Sync agents from repo to OpenCode config directory
# Run this after pulling changes or making edits

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config/opencode/agents"

mkdir -p "$CONFIG_DIR"

# Copy all .md files from repo to config
for f in "$REPO_DIR"/*.md; do
  [ -f "$f" ] || continue
  cp "$f" "$CONFIG_DIR/"
done

# Remove any .md files in config that aren't in the repo
for f in "$CONFIG_DIR"/*.md; do
  [ -f "$f" ] || continue
  [ ! -e "$REPO_DIR/$(basename "$f")" ] && rm "$f"
done

echo "Synced $(ls "$REPO_DIR"/*.md 2>/dev/null | wc -l) agents to $CONFIG_DIR"
