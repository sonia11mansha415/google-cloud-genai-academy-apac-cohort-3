<a id="top"></a>

> 🧭 [Repository Home](../../README.md) › [Track 2](../README.md) › **Testing & Results**

# 🧪 Track 2 Testing & Results

The final Track 2 implementation was validated locally and after Cloud Run deployment. PASS results below reflect observed evidence from the completed execution.

## Acceptance matrix

| ID | Test | Expected | Observed | Result | Evidence |
|---|---|---|---|---|---|
| T2-01 | Source/package validation | Final Python package compiles | `agent.py` and `__init__.py` passed `py_compile` | ✅ PASS | [Implementation](./implementation.md) |
| T2-02 | Local ADK Web | Agent launches in Web Preview | `data_agent` opened and responded locally | ✅ PASS | [01](../evidence/images/01-local-adk-bigquery-mcp-test.png) |
| T2-03 | Dataset discovery | Inspect Citi Bike data rather than answer generically | Agent surfaced `citibike_stations` and real schema fields | ✅ PASS | [01](../evidence/images/01-local-adk-bigquery-mcp-test.png) |
| T2-04 | MCP tool execution | Use managed BigQuery MCP tools | `list_table_ids`, `get_table_info`, and `execute_sql_readonly` appeared in the trace | ✅ PASS | [02](../evidence/images/02-mcp-tool-trace.png) |
| T2-05 | Read-only SQL | Analyze data without write-capable SQL | Query execution occurred through `execute_sql_readonly` | ✅ PASS | [02](../evidence/images/02-mcp-tool-trace.png) |
| T2-06 | Cloud Run deployment | Final revision deploys successfully | Revision deployed and served 100% of traffic | ✅ PASS | [04](../evidence/images/04-cloud-run-deployment.png) |
| T2-07 | Gemini location | Deployed model requests use the required global location | Global Gemini calls succeeded after deployment correction | ✅ PASS | [Troubleshooting](./troubleshooting.md) |
| T2-08 | Final coffee-truck task | Return three data-backed station recommendations | Three locations returned with trip and morning-commute evidence | ✅ PASS | [03](../evidence/images/03-deployed-three-station-result.png) |
| T2-09 | Final tool/reasoning flow | Stop once enough evidence is available | Final successful trace completed in 10 events with the needed MCP/SQL calls | ✅ PASS | [02](../evidence/images/02-mcp-tool-trace.png) |

## Test 1 — Local data discovery

**Prompt**

```text
What data do you have?
```

**Observed**

The local agent inspected the Citi Bike data and surfaced the `citibike_stations` table with fields including station identifiers, names, coordinates, capacity, bike/dock availability, and status indicators.

**Result:** ✅ PASS

![Local ADK BigQuery MCP test](../evidence/images/01-local-adk-bigquery-mcp-test.png)

## Test 2 — MCP tool trace

**Prompt**

```text
We have budget for 3 coffee trucks.

We want to find the best city bike stations to place our coffee trucks.
```

**Observed**

The deployed trace shows table discovery, schema inspection, and read-only SQL execution before the final response.

**Result:** ✅ PASS

![MCP tool trace](../evidence/images/02-mcp-tool-trace.png)

## Test 3 — Final deployed business result

**Observed recommendations**

1. **Pershing Square North (Grand Central Terminal)**
2. **E 17 St & Broadway (Union Square)**
3. **8 Ave & W 31 St (Penn Station Area)**

The response supported the recommendations with total trip volume and morning commuter activity from the Citi Bike dataset.

**Result:** ✅ PASS

![Final deployed result](../evidence/images/03-deployed-three-station-result.png)

## Test 4 — Cloud Run deployment

The final revision deployed successfully and served 100% of traffic.

**Result:** ✅ PASS

![Cloud Run deployment](../evidence/images/04-cloud-run-deployment.png)

## Reliability validation

The final completed run came after the model-location correction and the retry/efficiency changes documented in [`troubleshooting.md`](./troubleshooting.md). The successful run demonstrates that the final source could complete the full MCP + BigQuery + Gemini reasoning path after those changes.

## Final result

**Track 2 technical implementation:** ✅ Complete  
**Local BigQuery MCP validation:** ✅ Passed  
**Cloud Run deployment:** ✅ Passed  
**Final data-backed recommendation:** ✅ Passed  
**Track 2 assessment:** ✅ **10 / 10**

---

[🧱 Implementation](./implementation.md) · [🧠 Engineering Notes](./engineering-notes.md) · [🛠️ Troubleshooting](./troubleshooting.md) · [📊 Track 2](../README.md) · [↑ Back to top](#top)
