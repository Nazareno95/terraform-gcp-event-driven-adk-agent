import json
import os
import random
import uuid
from datetime import datetime, timezone

from flask import Flask, jsonify
from google.cloud import pubsub_v1

app = Flask(__name__)

project_id = os.environ["PROJECT_ID"]
topic_id = os.environ["PUBSUB_TOPIC"]

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(project_id, topic_id)


@app.route("/", methods=["GET"])
def publish_event():
    event = {
        "event_id": str(uuid.uuid4()),
        "transaction_id": str(uuid.uuid4()),
        "customer_id": f"CUST-{random.randint(1000, 9999)}",
        "amount": round(random.uniform(10, 5000), 2),
        "country": random.choice(["AR", "BR", "CL", "US", "MX"]),
        "event_timestamp": datetime.now(timezone.utc).isoformat(),
    }

    publisher.publish(topic_path, json.dumps(event).encode("utf-8"))

    return jsonify(event)