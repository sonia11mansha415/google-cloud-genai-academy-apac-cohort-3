<a id="top"></a>

> 🧭 [Repository Home](../../README.md) › [Track 1](../README.md) › **Engineering Notes**

# 🧠 Track 1 Engineering Notes

## From individual files to a customer-facing agent

This track helped me understand how the pieces of an AI-agent application fit together.

`agent.py` defines the model behavior and tool boundary. `app.py` turns that agent into an interface a customer can actually use. `menu.json` provides structured product data, and Cloud Run turns the local project into a reachable service.

Seeing those responsibilities separately made the project easier to reason about than treating the agent as one large script.

## Building the customer experience

I enjoyed the Streamlit part of the build because it made the agent feel like an application rather than a backend experiment.

The sidebar exposes the menu, prices, descriptions, tags, and allergen information while the chat accepts simple customer language. A customer can describe what they want — for example, *cold, strong, and dairy-free* — without knowing the exact product name first.

That interaction was one of the most useful parts of the exercise for me because it connected the model behavior to a clear user experience.

## Grounding became concrete during testing

The first recommendation test made the grounding concept much clearer. I asked for something cold, strong, and dairy-free, and the agent returned **Cold Brew Coffee** and **Nitro Cold Brew** from the menu.

The out-of-menu test was equally important. Asking for a Matcha Frappuccino challenged the agent to stay inside the catalog instead of producing a plausible but unavailable product.

The allergen test showed another side of grounding: the response had to use the menu metadata, not just general coffee knowledge.

## Deployment connected the application to cloud engineering

Cloud Run made the wider system visible. The Python files alone were not enough; the correct Google Cloud services, build process, runtime identity, IAM permissions, environment configuration, and deployment command all had to align.

Using a dedicated `barista-agent-sa` service account also connected the GenAI work back to the cloud-security principles I already care about: the workload should have an explicit identity and only the access it needs for its job.

## Firestore Vector Search was the strongest extension

After the core lab was working, I continued with Firestore Vector Search to understand how retrieval changes when the menu becomes a live database instead of a local file.

I generated embeddings for the menu, stored them with the Firestore documents, created the vector index, and changed `get_menu()` so the customer's text is embedded and matched against the catalog using nearest-neighbor search.

The most satisfying verification was adding **Matcha Green Tea Latte** directly to Firestore. I did not change the original `menu.json`. After refreshing the app, the product appeared in the sidebar and the agent could retrieve it for a Matcha request.

That single test made the difference between static grounding and live vector-backed retrieval much easier to understand.

## Security observations

A few controls stood out during the build:

- the deployed service uses a dedicated runtime identity;
- Vertex AI and Firestore access are granted through IAM roles rather than embedded credential files;
- no API key is hardcoded in the source;
- the menu/tool boundary constrains the recommendation task;
- negative testing is necessary because a correct-looking response is not enough proof that the boundary works.

The project also showed me where a production version would need more work: authentication, abuse controls, safer user-facing error handling, structured observability, tighter retrieval evaluation, and more adversarial prompt testing.

## Key takeaways

1. **Grounding needs evidence.** I trust the menu boundary more after testing an unavailable product than after simply reading the prompt instructions.
2. **UI changes how an agent is understood.** The Streamlit interface made the same logic much easier to evaluate from a customer's point of view.
3. **Cloud identity is part of the application.** Runtime permissions affect whether the deployed agent can actually use its model and data services.
4. **Vector retrieval is easier to understand when data changes live.** The Matcha test made that architecture change visible immediately.
5. **A useful agent is a system, not only a model call.** Data, tools, state, identity, deployment, testing, and the user experience all matter.

---

[🧱 Implementation](./implementation.md) · [🧪 Testing & Results](./testing-and-results.md) · [☕ Track 1](../README.md) · [↑ Back to top](#top)
