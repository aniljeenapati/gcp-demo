variable "project_id" {
  type        = string
  description = "GCP project ID"
  default     = "anil-461717"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "GCP zone"
  default     = "us-central1-a"
}

variable "app_repo_url" {
  type        = string
  description = "GitHub URL of the Flask app"
  default     = "https://github.com/aniljeenapati/gcp-demo.git"
}
