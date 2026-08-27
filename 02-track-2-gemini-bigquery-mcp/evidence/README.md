<a id="top"></a>

> 🧭 [Repository Home](../../README.md) › [Track 2](../README.md) › **Evidence**

# 🧾 Track 2 Evidence Index

## Completed build evidence

| File | What it proves |
|---|---|
| [`01-local-adk-bigquery-mcp-test.png`](./images/01-local-adk-bigquery-mcp-test.png) | Local ADK Web inspected real NYC Citi Bike tables and schema through BigQuery MCP |
| [`02-mcp-tool-trace.png`](./images/02-mcp-tool-trace.png) | Deployed run used `list_table_ids`, `get_table_info`, and `execute_sql_readonly` |
| [`03-deployed-three-station-result.png`](./images/03-deployed-three-station-result.png) | Final deployed answer returned three data-backed coffee-truck locations |
| [`04-cloud-run-deployment.png`](./images/04-cloud-run-deployment.png) | Final Cloud Run revision deployed and served 100% of traffic |

## Troubleshooting evidence

| File | What it proves |
|---|---|
| [`05-model-location-404-sanitized.png`](./images/05-model-location-404-sanitized.png) | Initial deployed model-location failure before the global location fix |
| [`06-adk-web-network-error.png`](./images/06-adk-web-network-error.png) | Generic network toast appeared even while MCP tool events were visible |
| [`07-vertex-resource-exhausted-429.png`](./images/07-vertex-resource-exhausted-429.png) | Later Gemini request failed with `429 RESOURCE_EXHAUSTED` |

## Local dataset discovery

![Local ADK BigQuery MCP test](./images/01-local-adk-bigquery-mcp-test.png)

The local agent surfaced Citi Bike station schema information before deployment.

## MCP tool trace

![MCP tool trace](./images/02-mcp-tool-trace.png)

The deployed event chain shows the actual BigQuery MCP tools used for the coffee-truck analysis.

## Final deployed result

![Final deployed result](./images/03-deployed-three-station-result.png)

The completed deployed run returned three locations supported by trip-volume and morning-commute analysis.

## Cloud Run deployment

![Cloud Run deployment](./images/04-cloud-run-deployment.png)

The final revision deployed successfully and served 100% of traffic.

## Diagnostic logs

The deep evidence directory contains short sanitized excerpts used to verify model location, MCP success, streaming behavior, and the final successful runtime sequence.

- [`diagnostic-logs-sanitized.txt`](./logs/diagnostic-logs-sanitized.txt)
- [`runtime-success-sanitized.txt`](./logs/runtime-success-sanitized.txt)

---

[🛠️ Troubleshooting](../docs/troubleshooting.md) · [🧪 Testing & Results](../docs/testing-and-results.md) · [📊 Track 2](../README.md) · [↑ Back to top](#top)
