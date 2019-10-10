resource "google_service_account" "api" {
  account_id = "${var.name}-api"
}

resource "google_service_account_key" "api" {
  service_account_id = google_service_account.api.name
}

resource "google_project_iam_member" "api-logging-viewer" {
  role   = "roles/logging.viewer"
  member = "serviceAccount:${google_service_account.api.email}"
}

resource "google_project_iam_member" "api-logging-writer" {
  role   = "roles/logging.logWriter"
  member = "serviceAccount:${google_service_account.api.email}"
}

resource "google_project_iam_member" "api-storage" {
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.api.email}"
}
