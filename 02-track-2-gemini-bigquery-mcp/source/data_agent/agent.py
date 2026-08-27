import os

from google.adk.agents import LlmAgent
from google.adk.models import Gemini
from google.adk.tools.mcp_tool.mcp_toolset import McpToolset
from google.adk.tools.mcp_tool.mcp_session_manager import StreamableHTTPConnectionParams

import google.auth
from google.auth.transport.requests import Request
from google.genai import types

# Fetch Application Default Credentials (ADC)
_application_default_credentials, project_id = google.auth.default()
_request = Request()
_application_default_credentials.refresh(_request)

project_id = os.getenv("GOOGLE_CLOUD_PROJECT", project_id)
if not project_id:
    raise ValueError("GOOGLE_CLOUD_PROJECT environment variable is not set.")


def _adc_auth_header_provider(context=None) -> dict[str, str]:
    if not _application_default_credentials.valid:
        _application_default_credentials.refresh(_request)

    return {
        "Authorization": f"Bearer {_application_default_credentials.token}",
        "x-goog-user-project": project_id,
    }


bigquery_toolset = McpToolset(
    connection_params=StreamableHTTPConnectionParams(
        url="https://bigquery.googleapis.com/mcp",
        tool_filter=[
            "get_dataset_info",
            "list_table_ids",
            "get_table_info",
            "execute_sql_readonly",
        ],
    ),
    header_provider=_adc_auth_header_provider,
)

system_instruction = f"""
You are a helpful assistant that can answer questions about data in BigQuery.
To answer the user's question, use data you have access to by using tools `list_table_ids` and `get_table_info`.
Your data is in `bigquery-public-data.new_york_citibike` dataset (Citi Bike trips and stations in the NYC area.)

Plan of action:
0. ALWAYS start by analyzing dataset.
1. Analyze your data, investigate schema and dimensions by querying distinct values of columns using `execute_sql_readonly`.
   Output information about tables, columns, their data types and sets of values (for dimensions).
   Note which columns can be joined or used in aggregations/filters, and what type conversion may be needed for joining or aggregating.
   DO NOT MAKE ASSUMPTIONS ABOUT DATA (structure, type, values, relationships) BASED ON YOUR PRIOR KNOWLEDGE. ALWAYS VERIFY YOUR ASSUMPTIONS.
2. Understand and interpret the user's question.
3. Formulate a plan to answer the user's question.
4. Write a SQL query to retrieve relevant data in necessary form.
   This is where you must pay extra attention to column types and dimensions' sets of values.
5. Retrieve data by generating BigQuery SQL and using `execute_sql_readonly`.
   Always use Dry Run to verify SQL correctness.
   Use `{project_id}` to run BigQuery queries (`project_id` parameter of `execute_sql_readonly`).

Do not use LaTeX in your responses. When giving a final answer, use Markdown.
"""

root_agent = LlmAgent(
    model=Gemini(
        model="gemini-3.6-flash",
        retry_options=types.HttpRetryOptions(
            attempts=8,
            initial_delay=2.0,
            max_delay=30.0,
            exp_base=2.0,
            jitter=1.0,
            http_status_codes=[408, 429, 500, 502, 503, 504],
        ),
    ),
    name="data_agent",
    instruction=system_instruction
    + """
Efficiency rule:
- Do not repeatedly inspect the same table/schema.
- Reuse information already obtained during this invocation.
- For the coffee-truck placement task, inspect only the relevant Citi Bike tables.
- Use no more than 3 execute_sql_readonly calls once the schema is understood.
- As soon as enough data exists to select three stations, stop calling tools and give the final answer.
""",
    description="A helpful assistant that can answer questions using NYC Citibike data.",
    tools=[bigquery_toolset],
)
