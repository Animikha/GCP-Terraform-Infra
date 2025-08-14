project_id = "thinking-seer-464009-e2"
region     = "europe-west2"

// VPC variables
vpc_name = "vpc-one"
subnets = [
  {
    name   = "subnet-one"
    cidr   = "10.0.1.0/24"
    region = "europe-west2"
  },
  {
    name   = "subnet-two"
    cidr   = "10.0.2.0/24"
    region = "asia-south1"
  }
]

// GCS variables
bucket_name       = "bucket-one-0608251030"
bucket_location   = "europe-west2"
enable_versioning = true

// VM variables
instance_name = "vm-one"
machine_type  = "e2-medium"
zone          = "europe-west2-a"
source_image  = "ubuntu-os-cloud/ubuntu-2204-lts"
disk_size     = 15
disk_type     = "pd-standard"
network       = "vpc-one"
subnetwork    = "subnet-one"
# ssh_user       = "abhinav"
# ssh_public_key = "~/.ssh/id_rsa.pub"
tags = ["secure-web", "ssh-access", "web"]

vm_instances = {
  "vm-one" = {
    zone         = "europe-west2-a"
    machine_type = "e2-medium"
  }
  "vm-two" = {
    zone         = "europe-west2-b"
    machine_type = "e2-micro"
  }
}

// GKE variables

secondary_ip_range = [
  {
    range_name    = "gke-pods"
    ip_cidr_range = "10.0.4.0/22"
  },
  {
    range_name    = "gke-services"
    ip_cidr_range = "10.0.8.0/24"
  }
]

// MySQL DB variables
mysql_db_name                     = "mysql-db-one"
db_version                        = "MYSQL_8_4"
db_tier                           = "db-f1-micro"
sql_edition                       = "ENTERPRISE"
db_deletion_protection_enabled    = false
db_availability_type              = "REGIONAL"
db_disk_size                      = 15
db_disk_type                      = "PD_SSD"
db_binary_log_enabled             = true
db_backup_start_time              = "02:00"
db_transaction_log_retention_days = 7
db_maintenance_day                = 7
db_maintenance_hour               = 2
db_update_track                   = "stable"
db_user                           = "myuser"
db_password                       = "admin@123"
db_name                           = "mydatabase"
psc_ip_range_name                 = "cloud-sql-psc-ip-range-one"
psc_ip_range_prefix_length        = 24
