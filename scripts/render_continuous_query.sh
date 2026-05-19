#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-dev-data-agent-493217}"
DATASET_ID="${DATASET_ID:-retail_fraud_agent_dev}"
TOPIC_NAME="${TOPIC_NAME:-retail-fraud-agent-dev-events}"

mkdir -p build/sql

sed \
  -e "s/\${PROJECT_ID}/${PROJECT_ID}/g" \
  -e "s/\${DATASET_ID}/${DATASET_ID}/g" \
  -e "s/\${TOPIC_NAME}/${TOPIC_NAME}/g" \
  sql/continuous_queries/transaction_events.sql \
  > build/sql/transaction_events.rendered.sql

echo "Rendered SQL:"
echo "build/sql/transaction_events.rendered.sql"