output "gcs_bucket_name" {
  description = "Name of the GCS bucket"
  value       = module.gcs_backend.bucket_name
}

output "gcs_bucket_url" {
  description = "URL to access the GCS bucket"
  value       = module.gcs_backend.bucket_url
}

output "gcs_bucket_location" {
  description = "Location of the GCS bucket"
  value       = module.gcs_backend.bucket_location
}

output "gcs_bucket_self_link" {
  description = "Self link of the GCS bucket"
  value       = module.gcs_backend.bucket_self_link
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "IDs of the subnets"
  value       = module.vpc.subnet_ids
}

output "vm_instance_self_link" {
  description = "Self link of the VM instance"
  value       = module.vm_instance.instance_self_link
}

output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = module.vm_instance.vm_public_ip
}