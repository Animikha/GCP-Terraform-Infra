# Step 1: Reserve an IP range for PSC
resource "google_compute_global_address" "psc_ip_range" {
  name          = var.psc_ip_range_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  network       = "projects/${var.project_id}/global/networks/${var.vpc_name}"
  address       = "10.194.135.0"
  prefix_length = var.psc_ip_range_prefix_length
}
 
# Step 2: Create private service connection for Cloud SQL
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = "projects/${var.project_id}/global/networks/${var.vpc_name}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.psc_ip_range.name]
 
  depends_on = [google_compute_global_address.psc_ip_range]
}
 
# Step 3: Create the Cloud SQL instance
resource "google_sql_database_instance" "mysql_instance" {
  name             = var.mysql_db_name
  region           = var.region
  database_version = var.db_version
  deletion_protection = false

  
  depends_on = [google_service_networking_connection.private_vpc_connection]


 
  settings {
    tier               = var.db_tier
    edition            = var.sql_edition
    deletion_protection_enabled = var.db_deletion_protection_enabled
    availability_type  = var.db_availability_type
    disk_size          = var.db_disk_size
    disk_type          = var.db_disk_type
    disk_autoresize    = true
 
    backup_configuration {
      enabled                         = true
      binary_log_enabled              = var.db_binary_log_enabled
      start_time                      = var.db_backup_start_time
      transaction_log_retention_days = var.db_transaction_log_retention_days
    }
 
    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/${var.project_id}/global/networks/${var.vpc_name}"
    }

 
    maintenance_window {
      day          = var.db_maintenance_day
      hour         = var.db_maintenance_hour
      update_track = var.db_update_track
    }
  }
}
 
# Step 4: Create a SQL user
resource "google_sql_user" "default" {
  name     = var.db_user
  instance = google_sql_database_instance.mysql_instance.name
  password = var.db_password
}
 
# Step 5: Create a database
resource "google_sql_database" "default" {
  name     = var.db_name
  instance = google_sql_database_instance.mysql_instance.name
}
 
