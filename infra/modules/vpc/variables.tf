variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnets with name, cidr, and region"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}

variable "secondary_ip_range"{
  description = "Secondary ip range for gke"
  type = list(object({
    range_name   = string
    ip_cidr_range   = string
  }))
}