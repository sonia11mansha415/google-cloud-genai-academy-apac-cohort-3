<a id="top"></a>

[🏠 Academy Home](../../README.md) · [☕ Track 1](../README.md) · **Engineering Notes**

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

# 🧠 Track 1 Engineering Notes

## 1. Start with a controlled source of truth

The agent is not supposed to act like a generic coffee expert. It is supposed to act like a barista for **this menu**.

That changes the design question from:

> "Can Gemini recommend coffee?"

into:

> "Can the agent recommend only what the controlled menu contains while respecting the product metadata that matters to the user?"

The menu tool becomes the grounding boundary.

## 2. Keep task data behind a tool

The model instructions describe behavior; the tool supplies the menu data. This separation makes the application easier to reason about and keeps the source of truth distinct from the prompt.

## 3. The UI is part of the agent system

Streamlit manages:

- chat input and output;
- active-session conversation state;
- visible menu context;
- error feedback;
- the interaction pattern the user experiences.

The browser session provides conversation continuity during the active session; it is not durable long-term memory.

## 4. Cloud Run changes the engineering context

Local application code becomes a service with a runtime identity, build process, environment configuration, API dependencies, network endpoint, and operational lifecycle.

The deployment therefore has to answer more than "does the Python file run?"

- Is the correct project selected?
- Are the required APIs enabled?
- Can the runtime identity call the model service?
- Does the application start on the port Cloud Run provides?
- Does the deployed service behave like the working application?

## 5. Least privilege is visible in the architecture

The codelab uses a dedicated service account for the Cloud Run workload. That reinforces a simple security principle: **the agent's capability should not automatically become the project's capability**.

## 6. Test the rule, not the fluency

A grounded agent should be challenged with cases that try to break its contract:

- ask for something the menu contains;
- ask for something the menu does not contain;
- introduce an allergen constraint;
- verify the deployed service, not only the local application.

The negative test matters because a fluent invented answer can still violate the source-of-truth boundary.

## 7. A pattern I can carry into later tracks

**Define the boundary → connect the tool/data source → deploy → test the boundary → preserve evidence.**

Track 2 extends that pattern into structured BigQuery data. Track 3 extends it into sandboxed execution and operational changes where human approval becomes more important.

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

[← Track 1](../README.md) · [Testing & Results →](./testing-and-results.md) · [Back to top](#top)
