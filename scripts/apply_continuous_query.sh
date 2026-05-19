#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-dev-data-agent-493217}"
LOCATION="${LOCATION:-US}"

./scripts/render_continuous_query.sh

bq query \
  --project_id="${PROJECT_ID}" \
  --location="${LOCATION}" \
  --use_legacy_sql=false \
  < build/sql/transaction_events.rendered.sql