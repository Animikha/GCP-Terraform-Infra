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
bucket_name = "bucket-one-0608251030"
bucket_location = "europe-west2"
enable_versioning = true

