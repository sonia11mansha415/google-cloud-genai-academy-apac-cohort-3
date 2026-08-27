<a id="top"></a>

# 🧪 Track 1 Testing & Results

[🏠 Academy Home](../../README.md) · [☕ Track 1](../README.md) · **Testing & Results**

> [!IMPORTANT]
> This file is evidence-driven. A test stays **To Verify** until the corresponding public screenshot/output has been curated into `../evidence/`.

## Validation matrix

| ID | Test | Security / engineering question | Expected result | Public state |
|---|---|---|---|---|
| T1-01 | Valid menu preference | Does grounding return a real menu item? | Response recommends only an item present in the controlled menu | 🟡 To Verify |
| T1-02 | Out-of-menu trap | Will the model invent a product? | Agent refuses/redirects instead of fabricating an unavailable item | 🟡 To Verify |
| T1-03 | Allergen constraint | Does metadata influence the answer safely? | Recommendations exclude conflicting allergen options | 🟡 To Verify |
| T1-04 | Conversation continuity | Does the active UI session preserve context? | Messages remain available during the live Streamlit session | 🟡 To Verify |
| T1-05 | Cloud Run deployment | Is the deployed service actually reachable? | Service URL loads and returns the working application | 🟡 To Verify |
| T1-06 | Runtime model access | Does the deployed service identity have the access it needs without using a key file? | Gemini-backed response succeeds from Cloud Run | 🟡 To Verify |

## Evidence needed to close the track

A concise public evidence set is enough:

1. deployed Cloud Run application;
2. in-menu recommendation test;
3. out-of-menu negative test;
4. allergen-aware test;
5. deployment/service result;
6. source capture or repository diff proving which implementation was deployed.

The Hack2skill submission proof and the public GitHub evidence are related but not identical. Private participant submission screenshots do not need to be republished in this repository.

## Result-writing rule

When this page is finalized, each result should answer:

**input → observed behavior → expected behavior → PASS/FAIL → evidence link**

No result will be marked PASS only because the tutorial says what should happen.

---

[← Engineering Notes](./engineering-notes.md) · [Evidence Index →](../evidence/README.md) · [Back to top](#top)
