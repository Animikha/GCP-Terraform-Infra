resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet" {
  count         = length(var.subnets)
  name          = var.subnets[count.index].name
  ip_cidr_range = var.subnets[count.index].cidr
  region        = var.subnets[count.index].region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "default" {
  name    = "${var.vpc_name}-allow-internal"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["10.0.0.0/8"]
  direction     = "INGRESS"
}
