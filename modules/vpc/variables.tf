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
