<a id="top"></a>

# 🧠 Track 1 Engineering Notes

[🏠 Academy Home](../../README.md) · [☕ Track 1](../README.md) · **Engineering Notes**

## 1. Start with a controlled source of truth

The agent is not supposed to act like a generic coffee expert. It is supposed to act like a barista for **this menu**.

That changes the design question from:

> "Can Gemini recommend coffee?"

into:

> "Can the agent recommend only what the controlled menu actually contains, while respecting the product metadata that matters to the user?"

The menu tool becomes the grounding boundary.

## 2. Tool-backed grounding instead of stuffing data into instructions

Keeping data behind a tool makes the application structure clearer. The model instructions describe behavior; the tool provides current task data. This separation becomes increasingly important as a dataset grows beyond a handful of tutorial records.

## 3. The UI is part of the agent system

Streamlit is not only decoration. It manages:

- the chat input/output surface;
- active-session conversation state;
- the visible menu context;
- error feedback;
- the interaction pattern that users actually experience.

One limitation is important: browser-session state is not durable memory. Closing or resetting the session is different from persisting a user conversation in a production data store.

## 4. Cloud Run changes the engineering context

Local code becomes a service with a runtime identity, build process, environment variables, API dependencies, network endpoint, and operational lifecycle.

The deployment therefore has to answer more questions than "does the Python file run?"

- Is the correct project selected?
- Are the required APIs enabled?
- Can the runtime identity call the model service?
- Does the application start on the port Cloud Run provides?
- Does the deployed service behave the same way as the local implementation?

## 5. Least privilege is visible in a tutorial too

The codelab uses a dedicated service account for the Cloud Run workload instead of defaulting to a broadly privileged runtime identity. That is a small architectural choice with a large security lesson: **the agent's capability should not automatically become the project's capability**.

## 6. Testing the rule matters more than admiring the response

A grounded agent should be challenged in ways that try to break its contract:

- ask for something the menu does contain;
- ask for something it does not contain;
- introduce an allergen constraint;
- verify the deployed version, not only local code.

The negative test is especially important because a fluent invented answer can look convincing even when it violates the application's source-of-truth boundary.

## 7. What I want to carry into later tracks

Track 1 gives me a reusable habit for the rest of the Academy:

**define the boundary → connect the tool/data source → deploy → test the boundary → preserve evidence.**

Track 2 extends that idea into structured enterprise data through BigQuery MCP. Track 3 extends it into code execution and operational changes, where human control becomes even more important.

---

[← Track 1](../README.md) · [Testing & Results →](./testing-and-results.md) · [Back to top](#top)
