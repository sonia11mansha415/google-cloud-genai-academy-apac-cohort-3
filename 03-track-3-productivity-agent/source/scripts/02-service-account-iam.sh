#!/usr/bin/env bash
set -euo pipefail

: "${GOOGLE_CLOUD_PROJECT:?Set GOOGLE_CLOUD_PROJECT first}"
SA_NAME="${SA_NAME:-coffee-shop-agent-sa}"
SERVICE_ACCOUNT_ADDRESS="${SERVICE_ACCOUNT_ADDRESS:-${SA_NAME}@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com}"

gcloud iam service-accounts create "$SA_NAME" \
  --description="Service account for the Coffee Shop Agent Codelab" \
  --display-name="Coffee Shop Agent SA"

gcloud projects add-iam-policy-binding "$GOOGLE_CLOUD_PROJECT" \
  --member="serviceAccount:$SERVICE_ACCOUNT_ADDRESS" \
  --role="roles/aiplatform.user"

gcloud iam service-accounts add-iam-policy-binding \
  "$SERVICE_ACCOUNT_ADDRESS" \
  --member="user:$(gcloud config get-value account)" \
  --role="roles/iam.serviceAccountTokenCreator"

echo "Service account created and IAM bindings applied."
echo "Share the Track 3 Google Sheet with the service account as Editor."
echo "Keep the historical data tab named exactly: POS-2025"
