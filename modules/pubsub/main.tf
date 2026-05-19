resource "google_pubsub_topic" "events" {
  project = var.project_id
  name    = var.topic_name

  labels = var.labels
}

resource "google_pubsub_subscription" "agent_subscription" {
  project = var.project_id
  name    = var.subscription_name
  topic   = google_pubsub_topic.events.id

  ack_deadline_seconds       = var.ack_deadline_seconds
  message_retention_duration = var.message_retention_duration

  retry_policy {
    minimum_backoff = "10s"
    maximum_backoff = "600s"
  }
}