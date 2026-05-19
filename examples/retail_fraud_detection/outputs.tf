output "dataset_id" {
  value = module.bigquery.dataset_id
}

output "pubsub_topic_name" {
  value = module.pubsub.topic_name
}

output "agent_service_account_email" {
  value = module.iam.service_account_email
}
output "simulator_service_uri" {
  value = module.cloud_run_simulator.service_uri
}