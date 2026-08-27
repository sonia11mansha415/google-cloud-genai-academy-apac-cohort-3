<a id="top"></a>

[🏠 Academy Home](../../README.md) · [☕ Track 1](../README.md) · **Testing & Results**

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

# 🧪 Track 1 Testing & Results

## Validation Matrix

| ID | Test | Engineering question | Expected result | Status |
|---|---|---|---|---|
| T1-01 | Valid menu preference | Does grounding return a real menu item? | Recommend an item present in the controlled menu | ⏳ Pending |
| T1-02 | Out-of-menu trap | Will the model invent a product? | Refuse or redirect instead of fabricating an unavailable item | ⏳ Pending |
| T1-03 | Allergen constraint | Does product metadata change the answer correctly? | Exclude options that conflict with the stated allergen constraint | ⏳ Pending |
| T1-04 | Conversation continuity | Does the active UI session preserve context? | Keep messages available during the live Streamlit session | ⏳ Pending |
| T1-05 | Cloud Run deployment | Is the deployed service reachable? | Load the working application from the Cloud Run URL | ⏳ Pending |
| T1-06 | Runtime model access | Can the deployed workload call Gemini through its runtime identity? | Return a Gemini-backed response from Cloud Run | ⏳ Pending |

## Result Format

Completed tests are recorded as:

**Input → Observed behavior → Expected behavior → PASS / FAIL → Evidence**

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif" width="100%" alt="section divider" />

[← Engineering Notes](./engineering-notes.md) · [Evidence Index →](../evidence/README.md) · [Back to top](#top)
