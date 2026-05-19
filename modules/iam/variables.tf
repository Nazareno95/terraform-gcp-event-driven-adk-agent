variable "project_id" {
  type = string
}

variable "service_account_id" {
  type    = string
  default = "event-driven-adk-agent"
}

variable "roles" {
  type = list(string)

  default = [
    "roles/bigquery.dataViewer",
    "roles/bigquery.jobUser",
    "roles/pubsub.subscriber",
    "roles/aiplatform.user",
    "roles/pubsub.publisher",
    "roles/run.invoker",
    "roles/artifactregistry.reader"
  ]
}