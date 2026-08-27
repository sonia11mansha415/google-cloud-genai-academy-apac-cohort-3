<a id="top"></a>

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0B57D0,100:7C4DFF&height=155&section=header&text=Track%202%20%E2%80%94%20Gemini%20%2B%20BigQuery%20MCP&fontSize=31&fontColor=ffffff&animation=fadeIn&desc=ADK%20Data%20Agent%20%E2%80%A2%20Managed%20MCP%20%E2%80%A2%20Cloud%20Run&descSize=15&descAlignY=69" width="100%" alt="Track 2 header" />

<div align="center">

![Status](https://img.shields.io/badge/Status-Queued-9AA0A6?style=for-the-badge)
![Gemini](https://img.shields.io/badge/Gemini-Agent-7C4DFF?style=for-the-badge)
![BigQuery](https://img.shields.io/badge/BigQuery-Structured%20Data-4285F4?style=for-the-badge&logo=googlebigquery&logoColor=white)
![MCP](https://img.shields.io/badge/MCP-Managed%20Tools-00B8D9?style=for-the-badge)

[← ☕ Track 1](../01-track-1-rag-adk-cloud-run/) · [🏠 Academy Home](../README.md) · **📊 Track 2** · [⚙️ Track 3 →](../03-track-3-productivity-agent/)

</div>

# 📊 Track 2 — Data Agent with Gemini + BigQuery MCP

**Status: Queued.**

Official codelab: **[Build and Deploy AI Agents with Gemini and BigQuery MCP server in Cloud Run](https://codelabs.developers.google.com/codelabs/cloud-run/cloud-run-adk-gemini-bq-mcp)**

## 🎯 Engineering Mission

Build an ADK data agent that can inspect BigQuery structure, use the managed BigQuery MCP server, formulate read-only SQL, validate assumptions against real schema/data, and deploy the agent to Cloud Run.

The business exercise asks the agent to reason over public Citi Bike data and identify promising locations for a small set of coffee trucks.

## 🏗️ Planned Architecture

```mermaid
flowchart LR
    U[User Question] --> A[ADK Data Agent]
    A --> G[Gemini]
    A --> M[BigQuery MCP Server]
    M --> B[(BigQuery)]
    B --> M
    M --> A
    A --> U
    A -. deployed as .-> C[Cloud Run]

    classDef app fill:#0B57D0,stroke:#8AB4F8,color:#fff,stroke-width:2px;
    classDef model fill:#311B92,stroke:#7C4DFF,color:#fff,stroke-width:2px;
    classDef data fill:#063970,stroke:#00B8D9,color:#fff,stroke-width:2px;
    class U,A,C app;
    class G model;
    class M,B data;
```

## 🔐 Security Lens to Validate During Execution

One design choice already visible in the official codelab is worth preserving: the MCP toolset filters the agent to **read-oriented dataset inspection and read-only SQL execution**. That is a stronger default than giving an analytical agent mutation capability it does not need.

During execution I will specifically document:

- how application credentials are used to reach the managed MCP service;
- which MCP tools the agent can call;
- how read-only SQL limits accidental data modification;
- how the agent verifies schema and values before assuming relationships;
- how the deployed Cloud Run agent is validated against real query results.
 
---

<div align="center">

**Inspect the schema. Query the evidence. Let the data constrain the answer.**

[← Track 1](../01-track-1-rag-adk-cloud-run/) · [🏠 Academy Home](../README.md) · [Track 3 →](../03-track-3-productivity-agent/) · [Back to top](#top)

</div>
