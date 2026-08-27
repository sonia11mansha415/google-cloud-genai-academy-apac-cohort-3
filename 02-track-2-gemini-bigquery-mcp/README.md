<a id="top"></a>

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0B57D0,100:7C4DFF&height=155&section=header&text=Track%202%20%E2%80%94%20Gemini%20%2B%20BigQuery%20MCP&fontSize=31&fontColor=ffffff&animation=fadeIn&desc=ADK%20Data%20Agent%20%E2%80%A2%20Managed%20MCP%20%E2%80%A2%20Cloud%20Run&descSize=15&descAlignY=69" width="100%" alt="Track 2 header" />

<div align="center">

![Status](https://img.shields.io/badge/Status-Queued-9AA0A6?style=for-the-badge)
![Gemini](https://img.shields.io/badge/Gemini-Agent-7C4DFF?style=for-the-badge)
![BigQuery](https://img.shields.io/badge/BigQuery-Structured%20Data-4285F4?style=for-the-badge&logo=googlebigquery&logoColor=white)
![MCP](https://img.shields.io/badge/MCP-Managed%20Tools-00B8D9?style=for-the-badge)

[← ☕ Track 1](../01-track-1-rag-adk-cloud-run/) · [🏠 Academy Home](../README.md) · **📊 Track 2** · [⚙️ Track 3 →](../03-track-3-productivity-agent/)

</div>

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

# 📊 Track 2 — Data Agent with Gemini + BigQuery MCP

**Official codelab:** [Build and Deploy AI Agents with Gemini and BigQuery MCP server in Cloud Run](https://codelabs.developers.google.com/codelabs/cloud-run/cloud-run-adk-gemini-bq-mcp)

## 🎯 Engineering Mission

Build an ADK data agent that can inspect BigQuery structure, use the managed BigQuery MCP server, formulate read-oriented SQL, validate assumptions against real schema and data, and deploy the agent to Cloud Run.

The business exercise uses public Citi Bike data to reason about promising locations for a small set of coffee trucks.

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🏗️ Target Architecture

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

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🔐 Security Focus

- read-oriented dataset inspection and SQL execution;
- authenticated access to the managed BigQuery MCP service;
- clear visibility into the tools exposed to the agent;
- schema and value validation before relying on generated queries;
- Cloud Run workload identity for the deployed agent.

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

<div align="center">

**Inspect the schema. Query the evidence. Let the data constrain the answer.**

[← Track 1](../01-track-1-rag-adk-cloud-run/) · [🏠 Academy Home](../README.md) · [Track 3 →](../03-track-3-productivity-agent/) · [Back to top](#top)

</div>
