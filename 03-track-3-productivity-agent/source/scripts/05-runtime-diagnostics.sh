#!/usr/bin/env bash
set -euo pipefail

: "${GOOGLE_CLOUD_PROJECT:?Set GOOGLE_CLOUD_PROJECT first}"
REGION="${REGION:-us-central1}"
SERVICE="${SERVICE:-coffee-mgr-agent}"

printf '\n== Service identity ==\n'
gcloud run services describe "$SERVICE" \
  --region="$REGION" \
  --project="$GOOGLE_CLOUD_PROJECT" \
  --format="value(spec.template.spec.serviceAccountName)"

printf '\n== Recent service logs ==\n'
gcloud run services logs read "$SERVICE" \
  --region="$REGION" \
  --project="$GOOGLE_CLOUD_PROJECT" \
  --limit=80

printf '\n== Raw deployed Sheets-tool check ==\n'
SERVICE_URL="$(gcloud run services describe "$SERVICE" \
  --region="$REGION" \
  --project="$GOOGLE_CLOUD_PROJECT" \
  --format='value(status.url)')"

curl -sS \
  -X POST "$SERVICE_URL/chat" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt":"Troubleshooting only. Call read_spreadsheet_values using the configured spreadsheet ID and range POS-2025!A1:I5. Return the exact raw result from the tool. Do not infer or use general knowledge."
  }' | python3 -m json.tool
