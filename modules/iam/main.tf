resource "google_service_account" "agent" {
  project      = var.project_id
  account_id   = var.service_account_id
  display_name = "Event Driven ADK Agent Service Account"
}

resource "google_project_iam_member" "agent_roles" {
  for_each = toset(var.roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.agent.email}"
}