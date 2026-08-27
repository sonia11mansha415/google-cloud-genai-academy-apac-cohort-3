<a id="top"></a>

# 🧾 Track 1 Evidence Index

[🏠 Academy Home](../../README.md) · [☕ Track 1](../README.md) · **Evidence**

## Evidence status

**Curation pending.** The active Track 1 execution screenshots are not duplicated here until they have been selected, cropped, sanitized, and renamed.

## Recommended final set

| File | What it should prove |
|---|---|
| `01-project-and-api-ready.png` | Correct Track 1 environment without exposing private billing/account details |
| `02-grounding-source-ready.png` | Menu source exists and is valid |
| `03-agent-ui-working.png` | Streamlit + ADK application is functioning |
| `04-cloud-run-deployed.png` | Cloud Run deployment/service is successful |
| `05-grounded-positive-test.png` | Real menu recommendation behavior |
| `06-out-of-menu-negative-test.png` | Agent refuses or redirects an unavailable product request |
| `07-allergen-aware-test.png` | Dairy/allergen constraint changes the recommendation correctly |

## Screenshot caption standard

Every evidence image should have three short pieces of context when referenced from Markdown:

**What this shows** — the technical state visible in the image.  
**Why it matters** — which requirement or engineering question it supports.  
**Result** — what was verified.

## Public-safety checklist

Before an image is committed:

- crop browser tabs that are not part of the evidence;
- remove emails, participant-account menus and private dashboard context;
- hide project numbers and internal IDs when they add no technical value;
- never publish billing screens or payment information;
- verify there are no keys, tokens, credential files, cookies or private URLs;
- prefer one strong final screenshot over several nearly identical progress screenshots.

The original raw screenshots can remain in a private evidence archive; the public repository should contain only the curated set.

---

[← Testing & Results](../docs/testing-and-results.md) · [Track 1 Home](../README.md) · [Back to top](#top)
