resource "google_container_cluster" "gke" {

  name     = "gke-cluster-one"
  location = "asia-south1"

  network    = var.vpc_name
  subnetwork = var.subnet_name

  initial_node_count       = 1

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.gke-pods
    services_secondary_range_name = var.gke-services
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.subnet-two_range # Replace with actual IP ranges for security
      display_name = "All networks"
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  
node_config {
    machine_type = "e2-medium"
    disk_size_gb   = 15  # Reduce from default (100 GB or more)
    disk_type      = "pd-standard"  # Use standard disk if SSD isn't required


    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  enable_shielded_nodes = true
  
  deletion_protection = false

}
