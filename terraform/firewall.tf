resource "google_compute_firewall" "ssh" {
  name    = format("%s-allow-outside-tcp", var.name)
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = var.ports
  }
  source_ranges = var.source_range_all
  target_tags   = [format("%s-allow-out-tcp", var.name)]
}