#!/usr/bin/env bash
set -euo pipefail

: "${GOOGLE_CLOUD_PROJECT:?Set GOOGLE_CLOUD_PROJECT}"
export GOOGLE_CLOUD_REGION="${GOOGLE_CLOUD_REGION:-us-central1}"
export GOOGLE_CLOUD_LOCATION="${GOOGLE_CLOUD_LOCATION:-global}"

cd "$(dirname "$0")/.."

uv tool run --from google-adk==2.4.0 \
  adk deploy cloud_run \
    --with_ui \
    --project "$GOOGLE_CLOUD_PROJECT" \
    --region "$GOOGLE_CLOUD_REGION" \
    --service_name bq-data-agent \
    --app_name data_agent \
    data_agent \
    -- \
    --allow-unauthenticated \
    --max-instances 1 \
    --labels dev-tutorial=codelab-cloud-run-adk-gemini-bq-mcp \
    --set-env-vars GOOGLE_GENAI_USE_ENTERPRISE=True,GOOGLE_CLOUD_PROJECT=${GOOGLE_CLOUD_PROJECT},GOOGLE_CLOUD_LOCATION=${GOOGLE_CLOUD_LOCATION}
