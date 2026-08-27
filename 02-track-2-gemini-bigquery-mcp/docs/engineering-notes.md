<a id="top"></a>

> 🧭 [Repository Home](../../README.md) › [Track 2](../README.md) › **Engineering Notes**

# 🧠 Track 2 Engineering Notes

Track 2 changed the way I thought about a data agent. The useful part was not simply connecting Gemini to BigQuery; it was seeing how the model, authentication, tool boundary, schema inspection, SQL execution, deployment, and runtime failures interact as one system.

## MCP became visible instead of abstract

Before this build, MCP was easy to understand only as an architecture term. The ADK event trace made it concrete.

For the final coffee-truck task I could see calls such as:

- `list_table_ids`
- `get_table_info`
- `execute_sql_readonly`

That trace made it clear that the agent was not already "knowing" the Citi Bike database. It had to inspect the data through specific tools before it could reason from the results.

## Schema-first reasoning changed the quality of the workflow

The agent instruction deliberately says not to assume structure, types, values, or relationships from prior knowledge. It has to inspect the dataset and understand the schema before writing SQL.

That was one of the strongest data-engineering lessons for me. A fluent model answer is not enough when the question depends on structured data; the reasoning needs to be anchored to the real table and column definitions.

## ADC connected identity to tool access

The authentication layer also became much clearer during this track.

The source uses **Application Default Credentials** and a refreshable authorization header for the managed BigQuery MCP endpoint. No API key or downloaded service-account JSON is embedded in the agent source.

This helped separate two concerns in my mind:

- Gemini provides the reasoning;
- the Google Cloud identity determines whether the tool call is authorized.

## Read-only SQL is a meaningful boundary

The agent receives `execute_sql_readonly`, not a general write-capable SQL tool. For an analysis task, that is a sensible boundary: the model can inspect and calculate without being given authority to modify the analytical dataset.

It also reinforced something I care about from a security perspective: **the model's capability and the tool's authority should not be treated as the same thing**.

## The debugging became the strongest learning experience

The deployed failures were frustrating because the browser showed a generic `TypeError: network error`, which initially made the failure look like an MCP or connectivity problem.

The trace changed that assumption. BigQuery MCP calls were completing, including table inspection and read-only SQL. That meant the next step was not to rebuild MCP; it was to inspect the backend.

Cloud Run logs then showed that a later Gemini request could fail even after earlier HTTP requests had succeeded. Seeing `/run_sse` return 200 while a later model request failed helped me understand streaming more clearly: the stream can open successfully and still fail later inside the agent run.

A direct non-SSE `/run` diagnostic reproduced the `429 RESOURCE_EXHAUSTED`, which ruled out the browser stream as the only cause. That was the point where the diagnosis became much more precise.

## Reliability was more than retrying

The final solution did not replace the codelab architecture. I kept ADK, Gemini, BigQuery MCP, read-only SQL, the Citi Bike dataset, and Cloud Run.

The stabilization came from two smaller changes:

1. add retry/backoff at the ADK Gemini model layer for transient 408/429/5xx responses;
2. stop the agent from repeatedly rediscovering the same schema or continuing SQL calls after it already had enough evidence.

That second change was important. Repeated model/tool loops increase latency and API usage and create more opportunities for a transient failure. Reliability can improve by reducing unnecessary work as well as handling failures when they happen.

## The final result felt earned

The final trace was short enough to finish cleanly and showed the exact tool calls I had been trying to validate. The agent then returned three station recommendations with trip-volume and morning-commuter evidence.

After the earlier 404, network symptom, repeated 429s, and diagnostic detours, seeing the complete data-backed answer was satisfying because I understood much more about **why** it worked than I would have from a straight-line codelab run.

## Key takeaways

1. **Tool traces are evidence.** The event chain shows what the agent actually called rather than what I assume it called.
2. **Schema inspection matters.** Data agents should validate structure before generating SQL.
3. **Identity and reasoning are separate layers.** ADC authorizes the data tool; Gemini reasons over what the tool returns.
4. **A UI error can be a secondary symptom.** Backend logs and direct endpoint tests can isolate the real failing layer.
5. **HTTP 200 does not always mean the whole agent run succeeded.** A streaming request may open before a later internal call fails.
6. **Reliability includes efficiency.** Fewer redundant model/tool rounds reduce latency and exposure to transient failures.
7. **Read-only access is a useful design boundary.** Analytical agents do not need write authority just because they can reason about data.

---

[🧱 Implementation](./implementation.md) · [🧪 Testing & Results](./testing-and-results.md) · [🛠️ Troubleshooting](./troubleshooting.md) · [📊 Track 2](../README.md) · [↑ Back to top](#top)
