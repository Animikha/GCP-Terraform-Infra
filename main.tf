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

module "documentation" {
  source      = "./modules/documentation"
  doc_content = <<EOT
This Terraform configuration sets up a custom VPC with multiple subnets across regions.

- Project ID: ${var.project_id}
- Region: ${var.region}
- VPC Name: ${var.vpc_name}
- Subnets:
%{ for subnet in var.subnets ~}
  - ${subnet.name} (${subnet.cidr}) in ${subnet.region}
%{ endfor ~}

The VPC is provisioned using the 'vpc' module. This documentation is generated after the VPC is successfully created.
EOT

  depends_on = [module.vpc]
}

module "gcs_backend" {
  source            = "./modules/gcs_backend"
  bucket_name       = var.bucket_name
  bucket_location   = var.bucket_location
  project_id        = var.project_id
  enable_versioning = var.enable_versioning
   depends_on = [module.documentation]
}

