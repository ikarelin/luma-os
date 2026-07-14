#!/bin/sh
set -e

PROJECT_DIR="/home/ikarelin/luma_linux"
cd "$PROJECT_DIR"

if [ -f build-run.pid ] && kill -0 "$(cat build-run.pid)" 2>/dev/null; then
  echo "status: running pid $(cat build-run.pid)"
else
  echo "status: not running"
fi

echo "== images =="
ls -lh ./*.iso ./*.hybrid.iso 2>/dev/null || true

echo "== size =="
du -sh cache config 2>/dev/null || true
echo "chroot: size skipped to avoid touching pseudo-filesystems during live-build"

echo "== log tail =="
tail -80 build-run.log 2>/dev/null || true
