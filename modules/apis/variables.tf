variable "project_id" {
  type = string
}

variable "services" {
  type = list(string)

  default = [
    "bigquery.googleapis.com",
    "pubsub.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "aiplatform.googleapis.com",
    "run.googleapis.com",
    "artifactregistry.googleapis.com"
  ]
}