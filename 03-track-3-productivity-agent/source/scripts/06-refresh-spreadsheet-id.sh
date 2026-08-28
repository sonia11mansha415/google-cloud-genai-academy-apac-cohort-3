#!/usr/bin/env bash
set -euo pipefail

: "${GOOGLE_CLOUD_PROJECT:?Set GOOGLE_CLOUD_PROJECT first}"
REGION="${REGION:-us-central1}"
SERVICE="${SERVICE:-coffee-mgr-agent}"

read -r -p "Paste the private Track 3 Google Sheet URL: " SHEET_URL
SPREADSHEET_ID="$(printf '%s' "$SHEET_URL" | sed -n 's#.*\/d\/\([^/]*\).*#\1#p')"

if [[ -z "$SPREADSHEET_ID" ]]; then
  echo "Could not extract spreadsheet ID." >&2
  exit 1
fi

export SPREADSHEET_ID

echo "Spreadsheet ID extracted without printing it. Length: ${#SPREADSHEET_ID}"

gcloud run services update "$SERVICE" \
  --region="$REGION" \
  --project="$GOOGLE_CLOUD_PROJECT" \
  --update-env-vars="SPREADSHEET_ID=$SPREADSHEET_ID"
