import base64
import json
import os
from datetime import datetime, timezone
import time
from flask import Flask, jsonify, request
from google.cloud import bigquery

app = Flask(__name__)

PROJECT_ID = os.environ["PROJECT_ID"]
DATASET_ID = os.environ["DATASET_ID"]
AUDIT_TABLE = os.environ.get("AUDIT_TABLE", "agent_audit_log")

bq_client = bigquery.Client(project=PROJECT_ID)


@app.route("/", methods=["POST"])
def handle_pubsub_event():
    start_time = time.time()
    envelope = request.get_json(silent=True)

    if not envelope or "message" not in envelope:
        return jsonify({"error": "invalid Pub/Sub message"}), 400

    message = envelope["message"]
    data = message.get("data")

    if not data:
        return jsonify({"error": "missing message data"}), 400

    decoded = base64.b64decode(data).decode("utf-8")
    event = json.loads(decoded)

    amount = float(event.get("amount", 0))

    decision = "review_required" if amount >= 1000 else "approved"

    row = {
        "event_id": event.get("event_id") or event.get("transaction_id"),
        "agent_response": json.dumps(event),
        "decision": decision,
        "created_at": datetime.now(timezone.utc).isoformat(),
    }

    table_id = f"{PROJECT_ID}.{DATASET_ID}.{AUDIT_TABLE}"
    errors = bq_client.insert_rows_json(table_id, [row])

    if errors:
        return jsonify({"errors": errors}), 500

    latency_ms = (time.time() - start_time) * 1000

    metrics_row = {
    "metric_timestamp": datetime.now(timezone.utc).isoformat(),
    "events_processed": 1,
    "high_risk_events": 1 if decision == "review_required" else 0,
    "processing_latency_ms": latency_ms,
    }

    metrics_table = f"{PROJECT_ID}.{DATASET_ID}.agent_metrics"

    bq_client.insert_rows_json(metrics_table, [metrics_row])
    
    return jsonify({"status": "processed", "decision": decision})