#The below resource can be used for eastablishing tracking of a vm generated manually
resource "google_compute_instance" "vm1" {
  name         = "unknown"
  zone         = "unknown"
  machine_type = "unknown"

  boot_disk {
    initialize_params {
      image = "unknown"
    }
  }

  network_interface {
    network    = "unknown"
    subnetwork = "unknown"
  }
}

# Run terraform init first so that the module is initialised.
# Then run terraform import.
# terraform import module.imported_vms.google_compute_instance.vm1 projects/thinking-seer-464009-e2/zones/europe-west2-a/instances/manual-one130825.
# once you run the above command you get tracking successful message. Then can use "terraform state list" to see all tracked resources.
# Then you can also use "terraform state show <resource_name_as_shown_in_terraform_state_list>" to see the details of the tracked resource.
