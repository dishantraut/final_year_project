#!/usr/bin/env sh
set -e

# Run from repository root
cd "$(dirname "$0")"

# If a virtualenv exists at ./venv, activate it
if [ -f "./venv/bin/activate" ]; then
  # shellcheck source=/dev/null
  . ./venv/bin/activate
fi

# Start the app with autoreload for local development
exec uvicorn app:app --reload --host 0.0.0.0 --port 8000