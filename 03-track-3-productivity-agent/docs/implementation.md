<a id="top"></a>

> 🧭 [Repository Home](../../README.md) › [Track 3](../README.md) › **Implementation**

# 🧱 Track 3 Implementation

This document preserves the main build sequence and the commands that matter for reproducing the Track 3 architecture. Private spreadsheet values are represented with placeholders.

## 1. Environment and required services

Set the project, region, and workload identity values used by the lab:

```bash
export GOOGLE_CLOUD_PROJECT="<PROJECT_ID>"
export REGION="us-central1"
export SA_NAME="coffee-shop-agent-sa"
export SERVICE_ACCOUNT_ADDRESS="${SA_NAME}@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com"

gcloud config set project "$GOOGLE_CLOUD_PROJECT"
gcloud config set run/region "$REGION"
```

Enable the required services:

```bash
gcloud services enable --project "$GOOGLE_CLOUD_PROJECT" \
  run.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  sheets.googleapis.com \
  aiplatform.googleapis.com
```

## 2. Dedicated service account and IAM

Create the runtime service account:

```bash
gcloud iam service-accounts create "$SA_NAME" \
  --description="Service account for the Coffee Shop Agent Codelab" \
  --display-name="Coffee Shop Agent SA"
```

Grant Vertex AI access to the workload identity:

```bash
gcloud projects add-iam-policy-binding "$GOOGLE_CLOUD_PROJECT" \
  --member="serviceAccount:$SERVICE_ACCOUNT_ADDRESS" \
  --role="roles/aiplatform.user"
```

Allow the signed-in user to impersonate the service account for local/test work:

```bash
gcloud iam service-accounts add-iam-policy-binding \
  "$SERVICE_ACCOUNT_ADDRESS" \
  --member="user:$(gcloud config get-value account)" \
  --role="roles/iam.serviceAccountTokenCreator"
```

The Google Sheet was shared directly with the service account as Editor. No downloaded service-account JSON was required.

## 3. Prepare the historical data

The historical data tab must be named exactly:

```text
POS-2025
```

The official historical dataset used during the build is preserved at:

[`../data/POS-2025.csv`](../data/POS-2025.csv)

The graduation prompt used for the final test is preserved at:

[`../data/graduation-schedule-prompt.txt`](../data/graduation-schedule-prompt.txt)

The private spreadsheet identifier was loaded only into the shell/runtime environment:

```bash
export SPREADSHEET_ID="<PRIVATE_SPREADSHEET_ID>"
```

## 4. Build the application

The final source consists of:

```text
source/
├── main.py
├── requirements.txt
├── Dockerfile
├── .env.example
└── scripts/
```

`main.py` contains:

- the FastAPI application;
- WebSocket `/ws` chat transport;
- HTTP `/chat` diagnostic fallback;
- Google Sheets read/write/create-tab tools;
- Cloud Run Sandbox-compatible command execution;
- ADK `LlmAgent` and runner;
- the human-approval instruction;
- the browser chat UI.

## 5. Validate the application before deployment

```bash
cd source
python3 -m py_compile main.py
```

Useful structural checks:

```bash
grep -n 'POS-2025' main.py
grep -n 'TODO-2026' main.py | head
grep -n 'SANDBOX_CLI' main.py | head
grep -n '@app.websocket("/ws")' main.py
```

## 6. Deploy with Cloud Run Sandbox

The successful deployment uses the codelab's sandbox-enabled Cloud Run path:

```bash
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
```

The final deployment created a serving revision and routed 100% of traffic to it.

## 7. Verify the deployed runtime

Check the service identity:

```bash
gcloud run services describe coffee-mgr-agent \
  --region="$REGION" \
  --project="$GOOGLE_CLOUD_PROJECT" \
  --format="value(spec.template.spec.serviceAccountName)"
```

Inspect recent runtime logs:

```bash
gcloud run services logs read coffee-mgr-agent \
  --region="$REGION" \
  --project="$GOOGLE_CLOUD_PROJECT" \
  --limit=80
```

## 8. Diagnose the Sheets data path

The first end-to-end run exposed a historical-data problem. To inspect the deployed backend directly, I called the `/chat` endpoint with a constrained prompt that requested the raw Sheet tool result:

```bash
SERVICE_URL="$(gcloud run services describe coffee-mgr-agent \
  --region="$REGION" \
  --project="$GOOGLE_CLOUD_PROJECT" \
  --format='value(status.url)')"

curl -sS \
  -X POST "$SERVICE_URL/chat" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt":"Troubleshooting only. Call read_spreadsheet_values using the configured spreadsheet ID and range POS-2025!A1:I5. Return the exact raw result from the tool. Do not infer or use general knowledge."
  }' | python3 -m json.tool
```

The decisive response was:

```text
No data found in the specified range.
```

After the official CSV was populated in `POS-2025`, the same diagnostic returned actual rows.

If the Sheet linkage needs to be refreshed, the repository includes [`06-refresh-spreadsheet-id.sh`](../source/scripts/06-refresh-spreadsheet-id.sh), which extracts the ID without printing it and updates the Cloud Run environment variable.

## 9. Run the final workflow

The final test used the official graduation schedule prompt:

1. submit the 2026 schedule to the deployed chat UI;
2. let the agent read `POS-2025` and analyze the historical patterns;
3. verify the staffing/inventory recommendations;
4. confirm that the agent asks permission before modifying `TODO-2026`;
5. reply **Yes**;
6. verify the approved rows directly in Google Sheets.

The final evidence confirms both the recommendation phase and the post-approval write.

## Reusable shell helpers

The source tree includes public-safe helpers for:

- project/API preflight;
- service-account IAM;
- source validation;
- sandbox-enabled deployment;
- runtime diagnostics;
- private spreadsheet-ID refresh.

They reproduce the main operational command groups without storing private values.

---

[🧠 Engineering Notes](./engineering-notes.md) · [🧪 Testing & Results](./testing-and-results.md) · [🛠️ Troubleshooting](./troubleshooting.md) · [⚙️ Track 3](../README.md) · [↑ Back to top](#top)
