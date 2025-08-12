variable "project_id" {
  description = "Id of the project"
  type        = string
}

variable "region" {
  description = "Region of the project"
  type        = string
}

// variables for VPC

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnets with name, CIDR, and region"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}

// Variables for GCS

variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
}

variable "bucket_location" {
  description = "Location of the bucket"
  type        = string
}


variable "enable_versioning" {
  description = "Enable versioning for the GCS bucket"
  type        = bool
  default     = true
}

// Variables for VM

variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "zone" {
  description = "Region of the project"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
}
# the above three variables are not used now after introducing for_each and vm_instances variable
# given below

# To use for_each create a map as shown below:
variable "vm_instances" {
  description = "Map of VM instance configurations"
  type = map(object({
    zone         = string
    machine_type = string
  }))
}

variable "source_image" {
  description = "Source image for the VM boot disk"
  type        = string
}

variable "disk_size" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "Type of the boot disk"
  type        = string
  default     = "pd-standard"
}

variable "network" {
  description = "Name of the VPC network to attach the VM to"
  type        = string
}

variable "subnetwork" {
  description = "Name of the subnetwork to attach the VM to"
  type        = string
}


# variable "ssh_user" {
#   description = "Username for SSH access"
#   type        = string
# }

# variable "ssh_public_key" {
#   description = "Path to the public SSH key file"
#   type        = string
# }

variable "tags" {
  description = "List of network tags to apply to the VM"
  type        = list(string)
  default     = []
}
