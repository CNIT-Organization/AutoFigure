#!/usr/bin/env bash
set -euo pipefail

BACKEND_PORT="${AUTOFIGURE_BACKEND_PORT:-8796}"
BACKEND_HOST="${AUTOFIGURE_HOST:-0.0.0.0}"
FRONTEND_PORT="${PORT:-7860}"
FRONTEND_HOST="${AUTOFIGURE_FRONTEND_HOST:-0.0.0.0}"

export AUTOFIGURE_BACKEND_PORT="$BACKEND_PORT"
export AUTOFIGURE_HOST="$BACKEND_HOST"

python backend/app.py &
BACKEND_PID=$!

cleanup() {
    if kill -0 "$BACKEND_PID" >/dev/null 2>&1; then
        kill "$BACKEND_PID"
    fi
}
trap cleanup EXIT

cd frontend
node node_modules/next/dist/bin/next start -p "$FRONTEND_PORT" -H "$FRONTEND_HOST"
