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
output "artifact_registry_repository_url" {
  value = module.artifact_registry.docker_repository_url
}
output "agent_service_uri" {
  value = module.cloud_run_agent.service_uri
}