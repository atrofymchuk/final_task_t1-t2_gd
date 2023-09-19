#------Store terraform state in cloudstorage----------

terraform {
  backend "gcs" {
    bucket      = "atrofymchuk-t1t2course"
    prefix      = "terraform/state"
    credentials = "../gcp-key/gd-gcp-gridu-devops-t1-t2-e0c795825e24.json"
  }
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.76.0"
    }
  }
  required_version = ">= 0.14"
}

#data "google_container_engine_versions" "gke_version" {
#  location = var.zone
#  version_prefix = "1.25.10"
#}

resource "google_container_cluster" "primary" {
  name     = "${var.name}-cluster"
  location = var.zone

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  
  #node_config {
  #  machine_type = "n1-standard-2"
  #}
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  
#  version = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes

  node_config {
#    oauth_scopes = [
#      "https://www.googleapis.com/auth/logging.write",
#      "https://www.googleapis.com/auth/monitoring",
#    ]
    preemptible  = true
    machine_type = "n1-standard-2"
    labels = {
      env = var.name
    }
    tags         = [format("%s-allow-out-tcp", var.name)]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

}