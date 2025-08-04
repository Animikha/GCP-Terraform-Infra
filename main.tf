provider "google" {
  credentials = file("terraform-sa-key.json")
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_name = var.vpc_name
  subnets = var.subnets
}
