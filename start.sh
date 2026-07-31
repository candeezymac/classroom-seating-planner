#!/usr/bin/env bash
# Serves the app locally. Unlike the health-dashboard project, this app has
# no fetch() calls, so opening index.html directly (file://) also works —
# this script just matches the pattern other projects use, and is required
# once we're testing anything that needs a real origin (e.g. a backend API).
set -euo pipefail
cd "$(dirname "$0")"

PORT="${1:-8001}"

if lsof -i ":$PORT" -sTCP:LISTEN >/dev/null 2>&1; then
  echo "Something is already listening on port $PORT — open http://localhost:$PORT"
  exit 0
fi

echo "Serving http://localhost:$PORT (Ctrl+C to stop)"
python3 -m http.server "$PORT"
