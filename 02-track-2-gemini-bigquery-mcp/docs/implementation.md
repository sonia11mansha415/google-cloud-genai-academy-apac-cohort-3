<a id="top"></a>

> 🧭 [Repository Home](../../README.md) › [Track 2](../README.md) › **Implementation**

# 🧱 Track 2 Implementation

This document preserves the final reproducible build path for the Gemini + BigQuery MCP data agent. Commands are grouped by purpose rather than copied as a raw terminal transcript.

## Prerequisites

- Google Cloud project selected for Track 2
- Cloud Shell
- `gcloud` authenticated in the active session
- Cloud Run region: `us-central1`
- current project ID available through `GOOGLE_CLOUD_PROJECT`

## 1. Configure the environment

The local environment used the Cloud Run region separately from the Gemini API location.

```bash
gcloud config set project "$GOOGLE_CLOUD_PROJECT"
gcloud config set run/region us-central1

export GOOGLE_CLOUD_REGION="us-central1"
export GOOGLE_GENAI_USE_ENTERPRISE="True"
export GOOGLE_CLOUD_LOCATION="global"
```

A public-safe template is available at [`source/env.sh.example`](../source/env.sh.example).

## 2. Enable required Google Cloud APIs

```bash
gcloud services enable --project "$GOOGLE_CLOUD_PROJECT" \
  run.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  bigquery.googleapis.com \
  aiplatform.googleapis.com
```

These services support the Cloud Run deployment, build pipeline, artifact storage, BigQuery analysis, and Gemini/Vertex AI access used by the codelab.

## 3. Final application structure

```text
source/
├── data_agent/
│   ├── __init__.py
│   ├── agent.py
│   └── requirements.txt
├── env.sh.example
└── scripts/
    ├── 01-setup-track2.sh
    ├── 02-run-local-adk-web.sh
    ├── 03-deploy-cloud-run.sh
    ├── 04-get-service-url.sh
    └── 05-read-cloud-run-logs.sh
```

### Dependencies

```text
google-adk==2.4.*
mcp==1.29.*
```

## 4. Agent design

The final [`agent.py`](../source/data_agent/agent.py) has four important layers.

### ADC authentication

```python
_application_default_credentials, project_id = google.auth.default()
_application_default_credentials.refresh(_request)
```

The MCP header provider refreshes the credential when necessary and returns both the bearer token and `x-goog-user-project` header.

### Managed BigQuery MCP toolset

```python
bigquery_toolset = McpToolset(
    connection_params=StreamableHTTPConnectionParams(
        url="https://bigquery.googleapis.com/mcp",
        tool_filter=[
            "get_dataset_info",
            "list_table_ids",
            "get_table_info",
            "execute_sql_readonly",
        ],
    ),
    header_provider=_adc_auth_header_provider,
)
```

The important boundary is `execute_sql_readonly`: the agent can analyze the dataset without receiving a write-capable SQL tool.

### Schema-first instruction

The system instruction requires the agent to inspect tables, schema, data types, and dimension values before building SQL. It explicitly tells the model not to rely on prior assumptions about the dataset.

### Reliability and efficiency

The final Gemini configuration adds exponential retry/backoff for transient HTTP failures:

```python
model=Gemini(
    model="gemini-3.6-flash",
    retry_options=types.HttpRetryOptions(
        attempts=8,
        initial_delay=2.0,
        max_delay=30.0,
        exp_base=2.0,
        jitter=1.0,
        http_status_codes=[408, 429, 500, 502, 503, 504],
    ),
)
```

The final instruction also prevents repeated inspection of the same schema and stops tool use once enough data exists to answer the coffee-truck task.

## 5. Validate the Python package

```bash
cd source/data_agent
python3 -m py_compile agent.py __init__.py
```

A successful syntax check produces no Python error output.

## 6. Run ADK Web locally

From the Track 2 `source/` directory:

```bash
uv tool run --with "mcp==1.29.*" --from "google-adk[mcp]==2.4.*" \
  adk web --allow_origins="*" --port 8080 .
```

I opened Cloud Shell **Web Preview** on port `8080` and asked:

```text
What data do you have?
```

The local agent inspected the Citi Bike data and surfaced real station-table schema fields before the Cloud Run deployment.

## 7. Deploy to Cloud Run

The final deployment must pass the Gemini environment values into the Cloud Run revision.

```bash
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
```

`--with_ui` deploys the ADK Web interface with the agent. The codelab deployment uses `--allow-unauthenticated` for the exercise.

## 8. Final deployed business test

```text
We have budget for 3 coffee trucks.

We want to find the best city bike stations to place our coffee trucks.
```

The completed deployed run used BigQuery MCP tools and returned:

1. **Pershing Square North (Grand Central Terminal)**
2. **E 17 St & Broadway (Union Square)**
3. **8 Ave & W 31 St (Penn Station Area)**

The final answer included trip-volume and morning-commute metrics drawn from the Citi Bike data.

## 9. Log inspection used during diagnosis

```bash
gcloud run services logs read bq-data-agent \
  --project="$GOOGLE_CLOUD_PROJECT" \
  --region="$GOOGLE_CLOUD_REGION" \
  --limit=100
```

For focused debugging I also filtered Cloud Run revision logs for streaming requests, model failures, MCP calls, and timeout/error signatures. The sanitized diagnostic evidence is stored in [`evidence/logs/`](../evidence/logs/).

## 10. Reusable helpers

The [`source/scripts/`](../source/scripts/) directory contains replayable helpers for setup, local ADK Web, deployment, service-URL lookup, and log inspection. They are clean wrappers around the main command sequence preserved above.

---

[🧠 Engineering Notes](./engineering-notes.md) · [🧪 Testing & Results](./testing-and-results.md) · [🛠️ Troubleshooting](./troubleshooting.md) · [📊 Track 2](../README.md) · [↑ Back to top](#top)
