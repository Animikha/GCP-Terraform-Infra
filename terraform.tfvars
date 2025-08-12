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



