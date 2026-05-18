provider "google" {
  project = var.project_id
  region  = var.region
}

locals {
  labels = {
    project     = "event-driven-adk-agent"
    environment = var.environment
    managed_by  = "terraform"
  }
}
module "apis" {
  source = "../../modules/apis"

  project_id = var.project_id
}

module "bigquery" {
  source = "../../modules/bigquery"

  project_id                 = var.project_id
  dataset_id                 = "${var.dataset_prefix}_${var.environment}"
  location                   = var.bigquery_location
  delete_contents_on_destroy = var.delete_contents_on_destroy
  deletion_protection        = var.deletion_protection
  labels                     = local.labels
  depends_on = [module.apis]
}

module "pubsub" {
  source = "../../modules/pubsub"

  project_id        = var.project_id
  topic_name        = "${var.name_prefix}-${var.environment}-events"
  subscription_name = "${var.name_prefix}-${var.environment}-agent-sub"
  labels            = local.labels
  depends_on = [module.apis]
}

module "iam" {
  source = "../../modules/iam"

  project_id = var.project_id
  depends_on = [module.apis]
}

