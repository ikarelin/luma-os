#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_DIR="$ROOT_DIR/assets/upstream"
SNAPSHOT_DIR="$ROOT_DIR/config/includes.chroot/usr/src/lumaos/upstream"

update_repo() {
  local name="$1"
  local url="$2"
  local dir="$UPSTREAM_DIR/$name"

  mkdir -p "$UPSTREAM_DIR"

  if [[ -d "$dir/.git" ]]; then
    echo "Updating $name"
    git -C "$dir" remote set-url origin "$url"
    if ! timeout 180 git -C "$dir" -c http.lowSpeedLimit=1000 -c http.lowSpeedTime=30 pull --ff-only; then
      echo "warning: could not update $name; keeping existing cache" >&2
    fi
  else
    echo "Cloning $name"
    rm -rf "$dir"
    timeout 300 git -c http.lowSpeedLimit=1000 -c http.lowSpeedTime=30 clone --depth=1 "$url" "$dir"
  fi

  if [[ ! -x "$dir/install.sh" ]]; then
    echo "error: $dir/install.sh is missing or not executable" >&2
    exit 1
  fi
}

update_repo MacTahoe-gtk-theme https://github.com/vinceliuice/MacTahoe-gtk-theme.git
update_repo MacTahoe-icon-theme https://github.com/vinceliuice/MacTahoe-icon-theme.git

mkdir -p "$SNAPSHOT_DIR"
rsync -a --delete "$UPSTREAM_DIR/MacTahoe-gtk-theme/" "$SNAPSHOT_DIR/MacTahoe-gtk-theme/"
rsync -a --delete "$UPSTREAM_DIR/MacTahoe-icon-theme/" "$SNAPSHOT_DIR/MacTahoe-icon-theme/"

echo "MacTahoe cache snapshot updated in $SNAPSHOT_DIR"
