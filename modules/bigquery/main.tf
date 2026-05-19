resource "google_bigquery_dataset" "this" {
  dataset_id                 = var.dataset_id
  project                    = var.project_id
  location                   = var.location
  delete_contents_on_destroy = var.delete_contents_on_destroy

  labels = var.labels
}

resource "google_bigquery_table" "transactions" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.this.dataset_id
  table_id   = "transactions"

  deletion_protection = var.deletion_protection

  schema = jsonencode([
    { name = "transaction_id", type = "STRING", mode = "REQUIRED" },
    { name = "customer_id", type = "STRING", mode = "REQUIRED" },
    { name = "amount", type = "FLOAT", mode = "REQUIRED" },
    { name = "country", type = "STRING", mode = "NULLABLE" },
    { name = "event_timestamp", type = "TIMESTAMP", mode = "REQUIRED" }
  ])
}

resource "google_bigquery_table" "agent_audit_log" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.this.dataset_id
  table_id   = "agent_audit_log"

  deletion_protection = var.deletion_protection

  schema = jsonencode([
    { name = "event_id", type = "STRING", mode = "REQUIRED" },
    { name = "agent_response", type = "STRING", mode = "NULLABLE" },
    { name = "decision", type = "STRING", mode = "NULLABLE" },
    { name = "created_at", type = "TIMESTAMP", mode = "REQUIRED" }
  ])
}