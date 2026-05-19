resource "google_cloud_run_v2_service" "this" {
  project  = var.project_id
  name     = var.service_name
  location = var.region

  template {
    service_account = var.service_account_email

    containers {
      image = var.image

      env {
        name  = "PROJECT_ID"
        value = var.project_id
      }

      env {
        name  = "PUBSUB_TOPIC"
        value = var.pubsub_topic_name
      }
    }
  }

  labels = var.labels
}