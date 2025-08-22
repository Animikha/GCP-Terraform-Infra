# variable "instance_name" {}
# variable "machine_type" {}
# variable "zone" {}

# i have commented out the above three variables beacause now we use for_each
# and a custom map object variable called "vm_instances" from where the value
# is taken. The so in the root/main.tf only one variable called vm_instances have to
# be passed to the vm module from root/terraform.tfvars

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

variable "vm_instances" {
  description = "Map of VM instance configurations"
  type = map(object({
    zone         = string
    machine_type = string
  }))
}

variable "db_host" {
  description= "Ip address of mysql_db"
  type = string

}

variable "db_user" {
  description = "MySQL user"
  type        = string
}

variable "db_password" {
  description = "MySQL password"
  type        = string
  sensitive   = true
}