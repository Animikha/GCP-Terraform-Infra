# Normal outputs eithout count or for_each
# output "instance_self_link" {
#   value = google_compute_instance.vm[*].self_link
# }

# output "vm_public_ip" {
#   value = google_compute_instance.vm[*].network_interface[0].access_config[0].nat_ip
# }

# Output format when using count [*]
# output "instance_self_link" {
#   value = google_compute_instance.vm[*].self_link
# }

# output "vm_public_ip" {
#   value = google_compute_instance.vm[*].network_interface[0].access_config[0].nat_ip
# }

# Output format when using for_each
output "instance_self_link" {
  value = [
    for vm in google_compute_instance.vm : vm.self_link
  ]
  description = "for_each format for self_link of vm"
}

output "vm_public_ip" {
  value = [
    for something in google_compute_instance.vm : something.network_interface[0].access_config[0].nat_ip
  ]
  description = "for_each format for public ip of vm"
}
