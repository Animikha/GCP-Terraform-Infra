output "bucket_name" {
  description = "The name of the GCS bucket used for Terraform state"
  value       = google_storage_bucket.bucket.name
}

output "bucket_url" {
  description = "The URL to access the GCS bucket"
  value       = "https://console.cloud.google.com/storage/browser/${google_storage_bucket.bucket.name}"
}

output "bucket_location" {
  description = "The location of the GCS bucket"
  value       = google_storage_bucket.bucket.location
}

output "bucket_self_link" {
  description = "The self link of the GCS bucket"
  value       = google_storage_bucket.bucket.self_link
}
