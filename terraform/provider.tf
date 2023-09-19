provider "google" {
  credentials = file(var.keyfile)
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
