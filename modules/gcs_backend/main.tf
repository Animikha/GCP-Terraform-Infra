resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.bucket_location
  project  = var.project_id

  uniform_bucket_level_access = true

  versioning {
    enabled = var.enable_versioning
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30
    }
  }

}
