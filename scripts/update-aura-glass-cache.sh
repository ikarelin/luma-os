#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="${AURA_GLASS_SOURCE:-/home/ikarelin/aura-glass}"
SOURCE_CACHE="${AURA_GLASS_CACHE:-/home/ikarelin/.cache/aura-glass/src}"
SNAPSHOT_ROOT="$ROOT_DIR/config/includes.chroot/usr/src/lumaos/upstream"
THEME_SNAPSHOT="$SNAPSHOT_ROOT/aura-glass"
CACHE_SNAPSHOT="$SNAPSHOT_ROOT/aura-glass-cache"

if [[ ! -x "$SOURCE_DIR/install.sh" || ! -d "$SOURCE_DIR/.git" ]]; then
  echo "error: Aura Glass checkout not found at $SOURCE_DIR" >&2
  exit 1
fi

if ! timeout 180 git -C "$SOURCE_DIR" pull --ff-only; then
  echo "warning: could not update Aura Glass; keeping the local checkout" >&2
fi

python3 "$ROOT_DIR/scripts/cache-aura-extensions.py" "$SOURCE_DIR" \
  "$SOURCE_CACHE/luma-extensions" 48

rm -rf "$THEME_SNAPSHOT" "$CACHE_SNAPSHOT"
mkdir -p "$SNAPSHOT_ROOT" "$THEME_SNAPSHOT"
cp -a "$SOURCE_DIR/." "$THEME_SNAPSHOT/"

if [[ -d "$SOURCE_CACHE" ]]; then
  mkdir -p "$CACHE_SNAPSHOT"
  cp -a "$SOURCE_CACHE/." "$CACHE_SNAPSHOT/"
fi

printf 'Aura Glass snapshot: %s\n' "$(git -C "$THEME_SNAPSHOT" rev-parse --short HEAD)"
if [[ -d "$CACHE_SNAPSHOT" ]]; then
  printf 'Upstream cache entries: %s\n' "$(find "$CACHE_SNAPSHOT" -mindepth 1 -maxdepth 1 -type d | wc -l)"
else
  echo "Upstream cache entries: 0 (the build will download pinned dependencies)"
fi
