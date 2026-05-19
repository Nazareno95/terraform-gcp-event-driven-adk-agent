output "topic_id" {
  value = google_pubsub_topic.events.id
}

output "topic_name" {
  value = google_pubsub_topic.events.name
}

output "subscription_id" {
  value = google_pubsub_subscription.agent_subscription.id
}