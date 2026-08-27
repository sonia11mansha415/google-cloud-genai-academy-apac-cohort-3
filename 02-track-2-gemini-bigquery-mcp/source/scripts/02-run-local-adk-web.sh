#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

uv tool run --with "mcp==1.29.*" --from "google-adk[mcp]==2.4.*" \
  adk web --allow_origins="*" --port 8080 .
