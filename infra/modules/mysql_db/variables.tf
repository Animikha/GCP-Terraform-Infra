variable "project_id" {
  description = "Id of the project"
  type        = string
}

variable "mysql_db_name"{
    description = "Name of the MySQL Instance"
    type = string
}

variable "region" {
  description = "Region of the project" 
  type = string
}

variable "db_version" {
    description = "Version of database"
    type = string
}

variable "db_tier" {
    description = "Tier of database"
    type = string
}

variable "sql_edition" {
    description = "Edition of database"
    type = string
}

variable "db_deletion_protection_enabled" {
    description = "Whether deletion protection is enabled or not"
    type = bool
}

variable "db_availability_type" {
    description = "Availability type of database"
    type = string
}

variable "db_disk_size" {
    description = "Disk size of database"
    type = string
}

variable "db_disk_type" {
    description = "Disk type of database"
    type = string
}

variable "db_binary_log_enabled" {
    description = "Enable binary logging for replication and point-in-time recovery"
    type        = bool
}

variable "db_backup_start_time" {
  description = "Backup window start time"
  type        = string
}

variable "db_transaction_log_retention_days" {
  description = "Number of days to retain transaction logs"
  type        = number
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "db_maintenance_day" {
  description = "Maintenance day (1-7)"
  type        = number
}

variable "db_maintenance_hour" {
  description = "Maintenance hour (0-23)"
  type        = number
}

variable "db_update_track" {
  description = "Update track (e.g., stable)"
  type        = string
}

variable "db_user" {
  description = "MySQL user"
  type        = string
}

variable "db_password" {
  description = "MySQL password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database instance name"
  type        = string
}

variable "psc_ip_range_name" {
  description = "Name for the reserved IP range for private service connection"
  type        = string
}

variable "psc_ip_range_prefix_length" {
  description = "Prefix length for the reserved PSC IP range"
  type        = number
}




