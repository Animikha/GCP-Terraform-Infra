variable "instance_name" {}
variable "machine_type" {}
variable "zone" {}
variable "source_image" {}
variable "disk_size" {
  default = 10
}
variable "disk_type" {
  default = "pd-standard"
}
variable "network" {}
variable "subnetwork" {}
# variable "ssh_user" {}
# variable "ssh_public_key" {}
variable "tags" {
  type    = list(string)
  default = []
}
