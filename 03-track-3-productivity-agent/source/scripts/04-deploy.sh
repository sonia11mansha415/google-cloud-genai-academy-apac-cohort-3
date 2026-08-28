#!/usr/bin/env bash
set -euo pipefail

: "${GOOGLE_CLOUD_PROJECT:?Set GOOGLE_CLOUD_PROJECT first}"
: "${SPREADSHEET_ID:?Set SPREADSHEET_ID from the private Google Sheet URL first}"
REGION="${REGION:-us-central1}"
SA_NAME="${SA_NAME:-coffee-shop-agent-sa}"
SERVICE_ACCOUNT_ADDRESS="${SERVICE_ACCOUNT_ADDRESS:-${SA_NAME}@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com}"

cd "$(dirname "$0")/.."

gcloud beta run deploy coffee-mgr-agent \
  --source=. \
  --region="$REGION" \
  --sandbox-launcher \
  --max-instances=1 \
  --session-affinity \
  --allow-unauthenticated \
  --no-cpu-throttling \
  --labels dev-tutorial=codelab-cloud-run-personal-agent-coffee-shop \
  --set-env-vars "GOOGLE_GENAI_USE_VERTEXAI=1,GOOGLE_CLOUD_PROJECT=$GOOGLE_CLOUD_PROJECT,GOOGLE_CLOUD_LOCATION=global,SPREADSHEET_ID=$SPREADSHEET_ID" \
  --service-account "$SERVICE_ACCOUNT_ADDRESS"
