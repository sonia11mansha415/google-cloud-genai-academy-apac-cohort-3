<a id="top"></a>

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0B57D0,100:34A853&height=155&section=header&text=Track%203%20%E2%80%94%20Productivity%20Agent&fontSize=32&fontColor=ffffff&animation=fadeIn&desc=Cloud%20Run%20Sandboxes%20%E2%80%A2%20Google%20Sheets%20%E2%80%A2%20Human%20Approval&descSize=15&descAlignY=69" width="100%" alt="Track 3 header" />

<div align="center">

![Status](https://img.shields.io/badge/Status-Queued-9AA0A6?style=for-the-badge)
![ADK](https://img.shields.io/badge/Google-ADK-4285F4?style=for-the-badge)
![Sandbox](https://img.shields.io/badge/Cloud%20Run-Sandbox-34A853?style=for-the-badge)
![Sheets](https://img.shields.io/badge/Google%20Sheets-Operational%20Data-0F9D58?style=for-the-badge&logo=googlesheets&logoColor=white)

[← 📊 Track 2](../02-track-2-gemini-bigquery-mcp/) · [🏠 Academy Home](../README.md) · **⚙️ Track 3**

</div>

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

# ⚙️ Track 3 — Personal Productivity Agent on Cloud Run

**Official codelab:** [Run a personal agent on a Cloud Run service](https://codelabs.developers.google.com/codelabs/cloud-run/cloud-run-personal-agent-coffee-shop)

## 🎯 Engineering Mission

Build a personal AI assistant for a coffee-shop manager preparing for a high-demand weekend. The agent analyzes operational data, executes code inside a sandboxed environment, generates staffing and inventory recommendations, and waits for explicit approval before writing operational TODOs back to the spreadsheet.

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🏗️ Target Architecture

```mermaid
flowchart LR
    U[Manager] --> W[Chat / WebSocket UI]
    W --> A[ADK Productivity Agent]
    A --> G[Gemini]
    A --> S[Cloud Run Sandbox]
    A --> R[Read Google Sheet]
    S --> A
    R --> A
    A --> H{Human approval?}
    H -- No --> W
    H -- Yes --> X[Write approved TODOs]
    X --> D[(Google Sheet)]
    A -. deployed as .-> C[Cloud Run]

    classDef app fill:#063970,stroke:#00B8D9,color:#fff,stroke-width:2px;
    classDef safe fill:#1B5E20,stroke:#34A853,color:#fff,stroke-width:2px;
    classDef model fill:#311B92,stroke:#7C4DFF,color:#fff,stroke-width:2px;
    class U,W,A,C app;
    class G model;
    class S,R,H,X,D safe;
```

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🔐 Security & Control Model

- dedicated Cloud Run service identity;
- spreadsheet access through the workload identity rather than a downloaded key file;
- sandboxed code execution;
- explicit human approval before operational write actions;
- clear separation between analysis and mutation;
- visible handling of WebSocket and operational errors.

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

<div align="center">

**Analyze safely. Ask before acting. Verify the operational change.**

[← Track 2](../02-track-2-gemini-bigquery-mcp/) · [🏠 Academy Home](../README.md) · [Back to top](#top)

</div>
