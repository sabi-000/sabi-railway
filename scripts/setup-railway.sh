#!/usr/bin/env bash
set -euo pipefail

command -v railway >/dev/null 2>&1 || {
  echo "Railway CLI is not installed. Install it from https://docs.railway.com/cli and run: railway login" >&2
  exit 1
}

railway up -y
railway volume add --mount-path /data
railway domain

echo "Setup finished. Check the Railway dashboard for the generated domain."
