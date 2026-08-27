<a id="top"></a>

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0B57D0,100:00B8D9&height=155&section=header&text=Track%201%20%E2%80%94%20Grounded%20RAG%20Agent&fontSize=32&fontColor=ffffff&animation=fadeIn&desc=ADK%20%E2%80%A2%20Gemini%20%E2%80%A2%20Streamlit%20%E2%80%A2%20Cloud%20Run&descSize=16&descAlignY=69" width="100%" alt="Track 1 header" />

<div align="center">

![Status](https://img.shields.io/badge/Status-In%20Progress-FBBC04?style=for-the-badge)
![ADK](https://img.shields.io/badge/Google-ADK-4285F4?style=for-the-badge)
![Gemini](https://img.shields.io/badge/Gemini-Agent-7C4DFF?style=for-the-badge)
![RAG](https://img.shields.io/badge/RAG-Grounded%20Recommendations-00B8D9?style=for-the-badge)
![Cloud Run](https://img.shields.io/badge/Cloud%20Run-Deployment-34A853?style=for-the-badge&logo=googlecloud&logoColor=white)

[🏠 Academy Home](../README.md) · [🧭 Overview](../00-academy-overview/) · **☕ Track 1** · [📊 Track 2 →](../02-track-2-gemini-bigquery-mcp/)

</div>

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

# ☕ Track 1 — RAG AI Barista on Cloud Run

## 🎯 What I Am Building

Track 1 focuses on a customer-facing AI Barista that recommends products from a controlled coffee-shop menu. The agent must stay grounded in the available menu, respect product metadata such as allergens, maintain a conversational interface, and run as a deployed Cloud Run service.

**Official codelab:** [Deploy a RAG AI Agent in Streamlit using Google ADK and Cloud Run](https://codelabs.developers.google.com/codelabs/cloud-run/build-streamlit-rag-agent-google-adk-cloud-run)

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🧩 Problem → Solution

### Problem

A general LLM can produce plausible recommendations that are not connected to the shop's actual products. A menu-driven assistant needs a controlled source of truth and must not invent unavailable items or ignore allergen constraints.

### Solution

The ADK agent connects to a menu tool that supplies the product data used for recommendations. Gemini handles the conversational reasoning, Streamlit provides the chat experience, and Cloud Run hosts the application.

```mermaid
flowchart LR
    U[Customer] --> S[Streamlit Chat UI]
    S --> A[ADK Agent]
    A --> G[Gemini]
    A --> T[get_menu tool]
    T --> M[(Menu Data)]
    G --> A
    A --> S
    S --> U
    S -. deployed as .-> C[Cloud Run]

    classDef user fill:#0B57D0,stroke:#8AB4F8,color:#fff,stroke-width:2px;
    classDef app fill:#063970,stroke:#00B8D9,color:#fff,stroke-width:2px;
    classDef model fill:#311B92,stroke:#7C4DFF,color:#fff,stroke-width:2px;
    classDef data fill:#1B5E20,stroke:#34A853,color:#fff,stroke-width:2px;
    class U user;
    class S,A,C app;
    class G model;
    class T,M data;
```

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🧱 Build Path

| Stage | Engineering purpose |
|---|---|
| Project + API setup | Prepare the Google Cloud services required by the application |
| Menu grounding source | Provide the controlled product data used by the agent |
| ADK agent | Define the model instructions and menu tool behavior |
| Streamlit application | Present the conversation and menu experience |
| Cloud Run identity | Run the service with a dedicated workload identity |
| Cloud Run deployment | Publish the application as a managed service |
| Behavioral validation | Test grounding, unavailable products, allergens, and deployed behavior |

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🔐 Security Notes

The Cloud Run workload uses a dedicated service account with the model access required by the application rather than relying on a broadly privileged default runtime identity.

The grounding tool also creates an important data boundary: the model can reason about the menu, but the menu remains the source of truth for the product catalog.

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🧪 Validation Strategy

| Test | What it checks | Expected behavior |
|---|---|---|
| Strong + warm recommendation | Grounded selection | Recommend a suitable item that exists in the menu |
| Out-of-menu request | Hallucination resistance | Decline or redirect instead of inventing a product |
| Lactose-intolerant request | Allergen awareness | Restrict recommendations to options without a dairy conflict |
| Conversation continuity | Session behavior | Preserve the active Streamlit conversation while the session remains alive |
| Cloud Run access | Deployment | Load the working application from the deployed service URL |

[Open the detailed testing matrix](./docs/testing-and-results.md)

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

## 🧠 What This Track Is Teaching Me

The most important shift for me is that **model quality is not only about fluent answers**. A useful agent needs a source of truth, a controlled tool boundary, a deployable application layer, and tests that challenge the model to stay inside its rules.

The deployment also makes the wider system visible: runtime identity, APIs, environment configuration, build behavior, session state, and Cloud Run all affect whether the agent works reliably.

## 🔎 Detailed Documentation

- [Engineering notes](./docs/engineering-notes.md)
- [Testing & results](./docs/testing-and-results.md)
- [Evidence index](./evidence/README.md)


<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

<div align="center">

**Ground the model. Test the boundary. Deploy with intent.**

[🏠 Academy Home](../README.md) · [↑ Track 1 top](#top) · [Track 2 →](../02-track-2-gemini-bigquery-mcp/)

</div>
