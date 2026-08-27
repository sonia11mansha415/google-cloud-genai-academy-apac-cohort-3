<a id="top"></a>

> 🧭 [Repository Home](../../README.md) › [Track 1](../README.md) › **Implementation**

# 🧱 Track 1 Implementation

This document records the build sequence and the commands that were actually used for the Track 1 application.

## 1. Required Google Cloud services

```bash
gcloud services enable \
  run.googleapis.com \
  aiplatform.googleapis.com \
  cloudbuild.googleapis.com

gcloud services list --enabled
```

These services support the deployed application, Gemini access through Vertex AI, and source-based Cloud Run builds.

## 2. Project environment

```bash
export PROJECT_ID=$(gcloud config get-value project)
echo $PROJECT_ID

export REGION=asia-south1
echo $REGION

mkdir -p coffee-barista-agent
cd coffee-barista-agent
pwd
```

The codelab workspace was kept in a single `coffee-barista-agent` directory.

## 3. Initial menu source

The original menu was stored in `menu.json` and validated before it was used by the agent.

```bash
cloudshell edit menu.json
cat menu.json | python3 -m json.tool > /dev/null && echo "Valid JSON!"
```

The seed menu contains eight products with:

- name;
- description;
- price;
- tags;
- allergen metadata.

## 4. ADK agent and Streamlit application

The initial project files were created as:

```bash
cloudshell edit requirements.txt
cloudshell edit agent.py
cloudshell edit app.py
ls
```

The application was syntax-checked before deployment:

```bash
python3 -m py_compile agent.py app.py
```

### Application responsibilities

| File | Responsibility |
|---|---|
| `agent.py` | ADK `LlmAgent`, agent instructions, and menu retrieval tool |
| `app.py` | Streamlit page, visible menu, chat session, and ADK runner |
| `menu.json` | Original menu data used for grounding and Firestore seeding |
| `requirements.txt` | Python dependencies |

## 5. Dedicated Cloud Run runtime identity

A dedicated service account was created for the deployed workload:

```bash
gcloud iam service-accounts create barista-agent-sa \
  --description="Service account for Coffee Barista ADK agent on Cloud Run" \
  --display-name="Barista Agent Service Account"
```

Vertex AI access was granted to that service identity:

```bash
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:barista-agent-sa@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/aiplatform.user"
```

The identity was verified before deployment:

```bash
gcloud iam service-accounts describe \
  barista-agent-sa@$PROJECT_ID.iam.gserviceaccount.com \
  --format="value(email)"
```

## 6. Cloud Run deployment

```bash
gcloud run deploy coffee-barista \
  --source . \
  --region $REGION \
  --allow-unauthenticated \
  --labels dev-tutorial=codelab-streamlit-rag-adk \
  --command "/cnb/lifecycle/launcher" \
  --args "sh,-c,python3 -m streamlit run app.py --server.port=\$PORT --server.address=0.0.0.0 --server.enableCORS=false --server.enableXsrfProtection=false" \
  --service-account "barista-agent-sa@$PROJECT_ID.iam.gserviceaccount.com" \
  --set-env-vars GOOGLE_GENAI_USE_ENTERPRISE=TRUE,GOOGLE_CLOUD_PROJECT=$PROJECT_ID,GOOGLE_CLOUD_LOCATION=global
```

The source directory was built and deployed as the `coffee-barista` Cloud Run service.

## 7. Core RAG validation

Three customer-style prompts were used against the deployed app:

```text
I want something cold, strong, and dairy-free. What do you recommend?

Do you have a matcha frappuccino?

I'm lactose intolerant, what can I get?
```

The observed results are recorded in [Testing & Results](./testing-and-results.md).

## 8. Firestore Vector Search extension

After the core deployment passed its RAG tests, I completed the Firestore extension.

### Enable Firestore and create the database

```bash
gcloud services enable firestore.googleapis.com

gcloud firestore databases create \
  --database="coffee-menu" \
  --location=$REGION
```

### Install the Firestore and embedding libraries

```bash
pip3 install google-cloud-firestore==2.27.0 google-genai==2.11.0
```

The final `requirements.txt` contains:

```text
google-adk==2.2.0
streamlit==1.56.0
google-cloud-firestore==2.27.0
google-genai==2.11.0
```

### Seed Firestore with vector embeddings

`seed.py` loads each item from `menu.json`, generates an embedding with `text-embedding-005`, and writes the menu document plus its vector to the `menu` collection.

```bash
python3 seed.py
```

Expected completion message:

```text
Firestore menu collection seeded with vector embeddings successfully!
```

### Create the vector index

```bash
gcloud firestore indexes composite create \
  --collection-group=menu \
  --query-scope=COLLECTION \
  --database="coffee-menu" \
  --field-config=field-path=embedding,vector-config='{"dimension":"768", "flat": "{}"}'
```

Index state was checked with:

```bash
gcloud firestore indexes composite list --database="coffee-menu"
```

### Grant Firestore access to the runtime identity

```bash
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:barista-agent-sa@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/datastore.user"
```

## 9. Move retrieval from local JSON to Firestore

The final `agent.py` changed `get_menu()` from local-file loading to semantic retrieval:

1. embed the customer query with `text-embedding-005`;
2. search the Firestore `embedding` field using cosine distance;
3. return the nearest three menu documents;
4. remove the embedding values before sending menu data back to the agent.

The final `app.py` also reads the live Firestore `menu` collection for the sidebar.

The updated code was syntax-checked again:

```bash
python3 -m py_compile agent.py app.py
```

The same Cloud Run deployment command was then used to publish the Firestore-backed version.

## 10. Dynamic Firestore verification

The final verification added **Matcha Green Tea Latte** directly to Firestore with an embedding. This was performed as an inline Python command during the build rather than as a committed application script.

```bash
python3 -c "
import os
from google import genai
from google.cloud import firestore
from google.cloud.firestore_v1.vector import Vector

db = firestore.Client(database='coffee-menu')
client = genai.Client(
    vertexai=True,
    project=os.environ.get('PROJECT_ID'),
    location=os.environ.get('REGION', 'us-central1')
)

name = 'Matcha Green Tea Latte'
desc = 'Creamy steamed oat milk infused with premium Japanese matcha powder.'

res = client.models.embed_content(
    model='text-embedding-005',
    contents=f'{name}: {desc}'
)
embedding = res.embeddings[0].values

db.collection('menu').document('matcha-latte').set({
    'name': name,
    'description': desc,
    'price': 5.50,
    'tags': ['sweet', 'hot', 'dairy-free'],
    'allergens': [],
    'embedding': Vector(embedding)
})

print('Successfully added Matcha Latte with vector embeddings!')
"
```

The application was refreshed and tested with:

```text
Do you have any matcha drinks?
```

The new item appeared in the sidebar and was retrieved by the agent, confirming that the live Firestore collection had become the active menu source.

---

[🧪 Testing & Results](./testing-and-results.md) · [☕ Track 1](../README.md) · [↑ Back to top](#top)
