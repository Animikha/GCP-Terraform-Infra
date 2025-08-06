variable "project_id" {
  description = "Id of the project"
  type        = string
}

variable "region" {
  description = "Id of the project"
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