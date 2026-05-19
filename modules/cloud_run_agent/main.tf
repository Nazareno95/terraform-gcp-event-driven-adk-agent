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
        name  = "DATASET_ID"
        value = var.dataset_id
      }

      env {
        name  = "AUDIT_TABLE"
        value = var.audit_table
      }
    }
  }

  labels = var.labels
}
resource "google_cloud_run_v2_service_iam_member" "pubsub_invoker" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.this.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.service_account_email}"
}