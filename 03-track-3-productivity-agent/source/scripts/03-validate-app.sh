#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

ls -lh requirements.txt Dockerfile main.py
python3 -m py_compile main.py

echo "main.py syntax: OK"
echo "Critical checks:"
grep -n 'POS-2025' main.py
grep -n 'TODO-2026' main.py | head
grep -n 'SANDBOX_CLI' main.py | head
grep -n '@app.websocket("/ws")' main.py
