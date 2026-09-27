#!/bin/sh
set -e

PROJECT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$PROJECT_DIR"

if pgrep -f "$PROJECT_DIR/auto/build|lb build" >/dev/null 2>&1; then
  echo "build already running"
  exit 0
fi

if ls ./*.iso ./*.hybrid.iso ./*.zsync >/dev/null 2>&1; then
  ARCHIVE_DIR="artifacts/old/$(date +%Y%m%d-%H%M%S)"
  mkdir -p "$ARCHIVE_DIR"
  mv ./*.iso ./*.hybrid.iso ./*.zsync "$ARCHIVE_DIR"/ 2>/dev/null || true
  echo "archived previous images to $ARCHIVE_DIR"
fi

./scripts/update-aura-glass-cache.sh

if [ "${LUMA_PURGE:-0}" = "1" ]; then
  ./auto/purge
else
  ./auto/clean
fi
./auto/config

nohup sh -c '
  set -e
  (
    while :; do
      pkill -f "service-manager: org.deepin.Filemanager.Text[I]ndex" 2>/dev/null || true
      sleep 5
    done
  ) &
  GUARD_PID="$!"
  trap "kill \"$GUARD_PID\" 2>/dev/null || true" EXIT INT TERM
  ./auto/build
' > build-run.log 2>&1 < /dev/null &
echo "$!" > build-run.pid
echo "started build pid $(cat build-run.pid)"
