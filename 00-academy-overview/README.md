<a id="top"></a>

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0B57D0,100:7C4DFF&height=145&section=header&text=Academy%20Overview&fontSize=34&fontColor=ffffff&animation=fadeIn&desc=Cohort%203%20%E2%80%A2%20three%20tracks%20complete%20%E2%80%A2%20hands-on%20GenAI%20engineering&descSize=15&descAlignY=68" width="100%" alt="Academy overview" />

<div align="center">

[🏠 Repository Home](../README.md) · [☕ Track 1](../01-track-1-rag-adk-cloud-run/) · [📊 Track 2](../02-track-2-gemini-bigquery-mcp/) · [⚙️ Track 3](../03-track-3-productivity-agent/)

</div>

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

# 🧭 Academy Overview

I completed all three **Google Cloud Gen AI Academy APAC — Cohort 3** technical tracks, their workshops, codelabs, codelab submissions, and required assessments.

Across the three builds, I moved from **grounded retrieval**, to **data-connected reasoning**, to **human-approved operational action**.

## 🚦 Final Academy Progress

| Area | Status |
|---|---|
| Registration | ✅ Complete |
| Workshops | ✅ **3 / 3 complete** |
| Meet the Builders | ✅ Submitted |
| Mandatory Academy Quiz | ✅ **10 / 10** |
| Track 1 codelab | ✅ Complete |
| Track 1 Firestore Vector Search | ✅ Complete |
| Track 1 Quiz | ✅ **10 / 10** |
| Track 2 codelab | ✅ Complete |
| Track 2 Quiz | ✅ **10 / 10** |
| Track 3 codelab | ✅ Complete |
| Track 3 Quiz | ✅ **10 / 10** |
| Track codelab submissions | ✅ **3 / 3 submitted** |
| Ideathon | 🔐 Separate repository |

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🧪 Three Technical Tracks

| Track | Engineering problem | Core technologies | Status | Official codelab |
|---|---|---|---|---|
| **1 — Customer-facing AI agent** | Ground an AI Barista in controlled menu data, deploy it, then extend retrieval with Firestore Vector Search | ADK, Gemini, RAG, Streamlit, Cloud Run, Firestore | ✅ Complete | [Open](https://codelabs.developers.google.com/codelabs/cloud-run/build-streamlit-rag-agent-google-adk-cloud-run) |
| **2 — Data-connected AI agent** | Let an agent inspect and reason from BigQuery through managed MCP tools | ADK, Gemini, BigQuery, MCP, Cloud Run | ✅ Complete | [Open](https://codelabs.developers.google.com/codelabs/cloud-run/cloud-run-adk-gemini-bq-mcp) |
| **3 — Productivity agent** | Analyze historical operations in a sandbox, recommend changes, and gate Sheet writes behind explicit human approval | ADK, Gemini, FastAPI, WebSockets, Cloud Run Sandbox, Google Sheets | ✅ Complete | [Open](https://codelabs.developers.google.com/codelabs/cloud-run/cloud-run-personal-agent-coffee-shop) |

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## ☕ Track 1 Completion

Track 1 progressed from local menu grounding to a deployed Cloud Run application and then to Firestore Vector Search.

Key milestones:

- ADK agent + Streamlit customer interface;
- dedicated Cloud Run runtime identity;
- grounded preference, negative catalog, and allergen-aware tests;
- Firestore menu seeding with embeddings;
- Firestore vector index and semantic retrieval;
- dynamic Matcha item verification;
- Track 1 assessment: **10 / 10**.

[Open the completed Track 1 case study →](../01-track-1-rag-adk-cloud-run/)

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 📊 Track 2 Completion

Track 2 connected a Gemini-powered ADK agent to the managed BigQuery MCP service and the public NYC Citi Bike dataset.

Key milestones:

- ADC-authenticated managed MCP access;
- schema/table inspection before SQL;
- read-only SQL execution;
- local ADK Web validation;
- Cloud Run deployment;
- model-location, streaming, and resource-exhaustion troubleshooting;
- Gemini retry/backoff and tighter tool-loop behavior;
- final three-station coffee-truck recommendation;
- Track 2 assessment: **10 / 10**.

[Open the completed Track 2 case study →](../02-track-2-gemini-bigquery-mcp/)

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## ⚙️ Track 3 Completion

Track 3 connected an operational AI agent to historical POS data, sandboxed analysis, and Google Sheets while preserving an explicit approval boundary before writes.

Key milestones:

- FastAPI + WebSocket conversational interface;
- dedicated Cloud Run workload identity;
- Google Sheets read/create/update tools;
- Cloud Run Sandbox-compatible Python/shell analysis;
- data-path troubleshooting through logs and direct `/chat` diagnostics;
- historical `POS-2025` verification;
- data-backed staffing and inventory recommendations;
- explicit approval before the `TODO-2026` write;
- final operational Sheet verification;
- Track 3 assessment: **10 / 10**.

[Open the completed Track 3 case study →](../03-track-3-productivity-agent/)

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🧠 Academy Progression

| Track | What changed |
|---|---|
| **Track 1** | The agent learned from a controlled source of truth. |
| **Track 2** | The agent inspected and queried bounded analytical tools. |
| **Track 3** | The agent moved into operational action with an explicit human approval boundary. |

> ### **Grounded answers → Data-backed decisions → Human-approved actions**

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🔐 Ideathon

The Cohort 3 Ideathon challenge — **Secure Personal Gemini Journal** — continues as a separate build and repository.

[Open the official Ideathon codelab](https://codelabs.developers.google.com/codelabs/cloud-run/cloud-run-ai-challenge)

## 🌐 Community Milestone

Meet the Builders submission: ✅ Complete  
Public Cohort update: https://lnkd.in/p/g43pkrGc

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

<div align="center">

**Ground the knowledge. Query the data. Control the action.**

[Back to repository home](../README.md) · [Back to top](#top)

</div>
