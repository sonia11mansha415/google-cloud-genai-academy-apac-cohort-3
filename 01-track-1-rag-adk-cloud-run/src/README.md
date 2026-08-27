<a id="top"></a>

# 💻 Track 1 Source — Provenance First

[🏠 Academy Home](../../README.md) · [☕ Track 1](../README.md)

The Track 1 application was built during hands-on Cloud Shell execution. The public source folder is intentionally waiting for a **direct export of the real working files** rather than a reconstructed copy created after the fact.

## Expected source set

The official codelab's core implementation uses files in this shape:

```text
src/
├── agent.py
├── app.py
├── menu.json
└── requirements.txt
```

Only the files actually used by Sonia should be committed here.

## Source-capture checklist

Before committing the Cloud Shell export:

- remove project-specific temporary files;
- confirm there is no `.env`, `env.sh`, token, API key, credential JSON, or service-account private key;
- preserve applicable Google sample-code attribution/licensing notices;
- verify imports and dependency versions match the working deployment;
- compare the exported files with the deployed working directory before calling the source record complete.

## Why this matters

A portfolio should distinguish **what was really executed** from what could be recreated later. Keeping that boundary explicit makes the repository more trustworthy.

[Back to Track 1](../README.md) · [Back to top](#top)
