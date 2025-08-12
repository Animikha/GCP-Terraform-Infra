resource "google_compute_instance" "vm" {
  count = 2 # Set the count or number of vms to be created
  name         = "${var.instance_name}-${count.index}" # Sets the vm instance name according to the count (index starting from 0)
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
