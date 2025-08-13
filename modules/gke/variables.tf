variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "gke-pods" {
  description = "Name of ip range for pods"
  type        = string
}

variable "gke-services" {
  description = "Name of ip range for services"
  type        = string
}

variable "subnet-two_range" {
  description = "Ip range of subnet-two"
  type        =  string
}


