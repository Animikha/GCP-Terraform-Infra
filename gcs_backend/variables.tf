variable "bucket_name" {
  type        = string
  description = "Name of the GCS bucket"
}

variable "bucket_location" {
  type        = string
  description = "Location of the bucket"
}

variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "enable_versioning" {
  type        = bool
  default     = false
}
