resource "google_bigquery_table" "agent_metrics" {
  project    = var.project_id
  dataset_id = var.dataset_id
  table_id   = "agent_metrics"

  deletion_protection = var.deletion_protection

  schema = jsonencode([
    {
      name = "metric_timestamp",
      type = "TIMESTAMP",
      mode = "REQUIRED"
    },
    {
      name = "events_processed",
      type = "INTEGER",
      mode = "NULLABLE"
    },
    {
      name = "high_risk_events",
      type = "INTEGER",
      mode = "NULLABLE"
    },
    {
      name = "processing_latency_ms",
      type = "FLOAT",
      mode = "NULLABLE"
    }
  ])
}