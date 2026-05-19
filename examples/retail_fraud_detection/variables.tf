variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "bigquery_location" {
  type    = string
  default = "US"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "name_prefix" {
  type    = string
  default = "retail-fraud-agent"
}

variable "dataset_prefix" {
  type    = string
  default = "retail_fraud_agent"
}

variable "delete_contents_on_destroy" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type    = bool
  default = false
}
variable "simulator_image" {
  type    = string
  default = "us-docker.pkg.dev/cloudrun/container/hello"
}
variable "artifact_registry_repository_id" {
  type    = string
  default = "adk-agent-images"
}

variable "agent_image" {
  type    = string
  default = "us-docker.pkg.dev/cloudrun/container/hello"
}