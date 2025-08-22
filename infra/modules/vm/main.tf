resource "google_compute_instance" "vm" {
  for_each = var.vm_instances
  name = each.key
  # Set the count or number of vms to be created
  # count = 2 
  # # Sets the vm instance name according to the count (index starting from 0)
  # name         = "${var.instance_name}-${count.index}" 
  machine_type = each.value.machine_type
  zone         = each.value.zone

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
