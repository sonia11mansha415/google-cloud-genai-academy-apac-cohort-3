<a id="top"></a>

> 🧭 [Repository Home](../../README.md) › [Track 3](../README.md) › **Engineering Notes**

# 🧠 Track 3 Engineering Notes

Track 3 was the point where the Academy moved from agents that **answer** and **analyze** into an agent that can also **act on operational data**.

## The application felt more like a real operational tool

I enjoyed building the browser experience around FastAPI and WebSockets because the agent no longer felt like a single request/response experiment. The conversation remained open while the manager asked questions, reviewed recommendations, and then approved an operational change.

That made the UI important in a different way from Track 1. The interface was not only displaying an answer; it was carrying an approval decision that changed what the agent was allowed to do next.

## The tool boundaries became easier to see

The final agent has four distinct capabilities:

- read operational data;
- run analysis code;
- create a Sheet tab;
- update Sheet values.

Seeing those as separate tools made the control model much clearer. Reading historical data is not the same privilege as changing operational data, and the Track 3 workflow keeps those actions conceptually separate.

## Cloud Run Sandbox made execution boundaries practical

The sandbox tool was one of the most interesting parts of the build. The application checks for the production sandbox launcher and uses it when deployed, while keeping a local fallback for development.

That showed me how an agent can keep one analysis workflow while changing the execution boundary underneath it.

## The approval step changed how I thought about agent safety

The strongest Track 3 moment was the pause before the write.

The agent had already completed the useful work: it had read the historical POS data, identified demand and wait-time patterns, and produced staffing and inventory recommendations. But it still asked:

> Would you like me to add these tasks to your `TODO-2026` TODO list?

Only after I replied **Yes** did the Sheet update happen.

This made the difference between an **advisory agent** and an **action-capable agent** very concrete. As soon as the system can mutate operational data, the control boundary matters more than it does for a chatbot that only returns text.

## The debugging journey reinforced layer-by-layer diagnosis

The first deployed interaction was frustrating because the UI suggested a problem with `POS-2025`, but that message did not tell me which layer was actually failing.

I checked the deployed system instead of guessing:

- Cloud Run was healthy;
- the WebSocket was connected;
- the sandbox launched;
- the expected service identity was active;
- the runtime spreadsheet configuration was present.

The useful turning point came from calling the deployed Sheet tool path directly. The raw response showed that the expected range contained no data.

That experience reinforced the same lesson I carried from Track 2: **the visible symptom is not automatically the root cause**.

## What changed across the three Academy tracks

Track 1 taught me to control the information available to an agent.

Track 2 taught me to inspect and constrain the data tools an agent can use.

Track 3 added a new question: **when should the agent be allowed to change something?**

That progression—from grounding, to data reasoning, to controlled action—is the part of the Academy I found most valuable.

## Security observations I would carry forward

The lab already uses useful boundaries: workload identity, runtime configuration, sandboxed execution, separate read/write tools, and an explicit approval request.

The biggest improvement I would make for a stronger operational design is to move the approval gate out of instruction-only behavior and into deterministic application state. A write-capable tool should be rejected or unavailable until the application has recorded an explicit approval event.

I would also generate audit metadata such as timestamps in server-side code. The captured `Date_Added` value demonstrates why system-of-record fields should not be delegated to model-generated text.

---

[🧱 Implementation](./implementation.md) · [🧪 Testing & Results](./testing-and-results.md) · [🛠️ Troubleshooting](./troubleshooting.md) · [⚙️ Track 3](../README.md) · [↑ Back to top](#top)
