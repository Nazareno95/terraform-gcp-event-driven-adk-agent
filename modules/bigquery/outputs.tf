output "dataset_id" {
  value = google_bigquery_dataset.this.dataset_id
}

output "transactions_table_id" {
  value = google_bigquery_table.transactions.table_id
}

output "agent_audit_log_table_id" {
  value = google_bigquery_table.agent_audit_log.table_id
}