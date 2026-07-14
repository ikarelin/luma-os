#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BRAND_DIR="$ROOT_DIR/assets/brand/lumaos"
SOURCE_DIR="$BRAND_DIR/source"
PNG_DIR="$BRAND_DIR/exports/png"

if ! command -v rsvg-convert >/dev/null 2>&1; then
  echo "error: rsvg-convert is required to export PNG brand assets" >&2
  exit 1
fi

mkdir -p "$PNG_DIR"

for size in 16 24 32 48 64 128 256 512 1024; do
  rsvg-convert -w "$size" -h "$size" \
    -o "$PNG_DIR/lumaos-app-icon-${size}.png" \
    "$SOURCE_DIR/lumaos-app-icon.svg"

  rsvg-convert -w "$size" -h "$size" \
    -o "$PNG_DIR/lumaos-mark-${size}.png" \
    "$SOURCE_DIR/lumaos-mark.svg"
done

for size in 128 256 512; do
  rsvg-convert -w "$size" -h "$size" \
    -o "$PNG_DIR/lumaos-mark-mono-light-${size}.png" \
    "$SOURCE_DIR/lumaos-mark-mono-light.svg"

  rsvg-convert -w "$size" -h "$size" \
    -o "$PNG_DIR/lumaos-mark-mono-dark-${size}.png" \
    "$SOURCE_DIR/lumaos-mark-mono-dark.svg"
done

rsvg-convert -w 1240 -h 360 \
  -o "$PNG_DIR/lumaos-wordmark-1240x360.png" \
  "$SOURCE_DIR/lumaos-wordmark.svg"

rsvg-convert -w 640 -h 160 \
  -o "$PNG_DIR/lumaos-boot-logo-640x160.png" \
  "$SOURCE_DIR/lumaos-boot-logo.svg"

rsvg-convert -w 512 -h 128 \
  -o "$PNG_DIR/lumaos-boot-logo-512x128.png" \
  "$SOURCE_DIR/lumaos-boot-logo.svg"

echo "Exported LumaOS brand PNG assets to $PNG_DIR"
