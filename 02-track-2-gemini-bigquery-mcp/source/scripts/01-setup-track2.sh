#!/usr/bin/env bash
set -euo pipefail

: "${GOOGLE_CLOUD_PROJECT:?Set GOOGLE_CLOUD_PROJECT first, e.g. export GOOGLE_CLOUD_PROJECT=YOUR_PROJECT_ID}"
export GOOGLE_CLOUD_REGION="${GOOGLE_CLOUD_REGION:-us-central1}"

gcloud config set project "$GOOGLE_CLOUD_PROJECT"
gcloud config set run/region "$GOOGLE_CLOUD_REGION"

export GOOGLE_GENAI_USE_ENTERPRISE="True"
export GOOGLE_CLOUD_LOCATION="global"

gcloud services enable --project "$GOOGLE_CLOUD_PROJECT" \
  run.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  bigquery.googleapis.com \
  aiplatform.googleapis.com

echo "PROJECT=$GOOGLE_CLOUD_PROJECT"
echo "REGION=$GOOGLE_CLOUD_REGION"
echo "GENAI_ENTERPRISE=$GOOGLE_GENAI_USE_ENTERPRISE"
echo "GENAI_LOCATION=$GOOGLE_CLOUD_LOCATION"
