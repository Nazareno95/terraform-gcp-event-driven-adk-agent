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
  depends_on                 = [module.apis]
}

module "pubsub" {
  source = "../../modules/pubsub"

  project_id        = var.project_id
  topic_name        = "${var.name_prefix}-${var.environment}-events"
  subscription_name = "${var.name_prefix}-${var.environment}-agent-sub"
  labels            = local.labels
  depends_on        = [module.apis]
}

module "iam" {
  source = "../../modules/iam"

  project_id = var.project_id
  depends_on = [module.apis]
}
module "cloud_run_simulator" {
  source = "../../modules/cloud_run_simulator"

  project_id            = var.project_id
  region                = var.region
  service_name          = "${var.name_prefix}-${var.environment}-simulator"
  image                 = var.simulator_image
  service_account_email = module.iam.service_account_email
  pubsub_topic_name     = module.pubsub.topic_name
  labels                = local.labels

  depends_on = [module.apis, module.pubsub, module.iam]
}

