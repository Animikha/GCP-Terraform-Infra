resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.source_image
      size  = var.disk_size
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {} # Enables external IP
  }

#   metadata = {
#     ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
#   }
  metadata_startup_script = file("${path.module}/scripts/install-nginx.sh")
  tags = var.tags
}
