<a id="top"></a>

> 🧭 [Repository Home](../../README.md) › [Track 1](../README.md) › **Evidence**

# 🧾 Track 1 Evidence Index

| File | What it proves |
|---|---|
| [`01-grounded-recommendation.png`](./images/01-grounded-recommendation.png) | Deployed customer UI and grounded cold + strong + dairy-free recommendation |
| [`02-out-of-menu-test.png`](./images/02-out-of-menu-test.png) | The agent does not treat the unavailable Matcha Frappuccino as a real menu product |
| [`03-allergen-aware-test.png`](./images/03-allergen-aware-test.png) | Menu metadata is used to filter dairy-conflicting recommendations |
| [`04-firestore-vector-search.png`](./images/04-firestore-vector-search.png) | Firestore-backed Matcha item appears in the live menu and is retrieved by the agent |

## Grounded recommendation

![Grounded recommendation](./images/01-grounded-recommendation.png)

The deployed app matched a natural-language customer request to valid menu items.

## Out-of-menu boundary

![Out-of-menu test](./images/02-out-of-menu-test.png)

The unavailable Matcha Frappuccino request did not produce a fabricated catalog item.

## Allergen-aware filtering

![Allergen-aware test](./images/03-allergen-aware-test.png)

The response filtered recommendations using the menu's recorded allergen metadata.

## Firestore Vector Search

![Firestore Vector Search](./images/04-firestore-vector-search.png)

A Matcha item added directly to Firestore became visible in the app and retrievable through the updated vector-search path.

---

[🧪 Testing & Results](../docs/testing-and-results.md) · [☕ Track 1](../README.md) · [↑ Back to top](#top)
