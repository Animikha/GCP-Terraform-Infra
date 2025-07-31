provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_name = "my-custom-vpc"

  subnets = [
    {
      name   = "subnet-1"
      cidr   = "10.0.1.0/24"
      region = "us-central1"
    },
    {
      name   = "subnet-2"
      cidr   = "10.0.2.0/24"
      region = "us-east1"
    }
  ]
}
