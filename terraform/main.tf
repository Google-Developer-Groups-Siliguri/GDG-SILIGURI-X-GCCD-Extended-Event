provider "google" {
  project     = "${var.project_id}"
  region      = "asia-south1"
}

# Define Google Project to get the project number
data "google_project" "project" {
  project_id = var.project_id
}

# Cloud Run Service
resource "google_cloud_run_service" "default" {
  name     = "flask-gcp-docker"
  location = "asia-south1"

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/flask-gcp-docker"
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Allow public access to the Cloud Run service
resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

# Output the Cloud Run URL
output "cloud_run_url" {
  value       = google_cloud_run_service.default.status[0].url
  description = "The URL of the deployed Cloud Run service"
}
