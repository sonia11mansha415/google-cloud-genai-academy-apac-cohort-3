#!/usr/bin/env bash
set -euo pipefail

# Public-safe execution template. Set GOOGLE_CLOUD_PROJECT before running.
: "${GOOGLE_CLOUD_PROJECT:?Set GOOGLE_CLOUD_PROJECT first}"
REGION="${REGION:-us-central1}"
SA_NAME="${SA_NAME:-coffee-shop-agent-sa}"
SERVICE_ACCOUNT_ADDRESS="${SA_NAME}@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com"

export GOOGLE_CLOUD_PROJECT REGION SA_NAME SERVICE_ACCOUNT_ADDRESS

gcloud config set project "$GOOGLE_CLOUD_PROJECT"
gcloud config set run/region "$REGION"

gcloud services enable --project "$GOOGLE_CLOUD_PROJECT" \
  run.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  sheets.googleapis.com \
  aiplatform.googleapis.com

echo "Project: $(gcloud config get-value project 2>/dev/null)"
echo "Region:  $(gcloud config get-value run/region 2>/dev/null)"
echo "Required APIs:"
gcloud services list --enabled \
  --project="$GOOGLE_CLOUD_PROJECT" \
  --filter="name:(run.googleapis.com OR cloudbuild.googleapis.com OR artifactregistry.googleapis.com OR sheets.googleapis.com OR aiplatform.googleapis.com)" \
  --format="value(config.name)"
