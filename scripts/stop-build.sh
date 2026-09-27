#!/bin/sh
set -e

PROJECT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$PROJECT_DIR"

if [ -f build-run.pid ]; then
  PID="$(cat build-run.pid)"
  if kill -0 "$PID" 2>/dev/null; then
    sudo kill "$PID" 2>/dev/null || true
  fi
fi

pgrep -f "$PROJECT_DIR/.*/lb build|$PROJECT_DIR/auto/build" | while read -r PID; do
  sudo kill "$PID" 2>/dev/null || true
done

pgrep -f "service-manager: org.deepin.Filemanager.Text[I]ndex" | while read -r PID; do
  kill "$PID" 2>/dev/null || true
done

echo "Build stop requested. If apt/dpkg is still finishing cleanup, wait a minute and run:"
echo "  ./scripts/build-status.sh"
