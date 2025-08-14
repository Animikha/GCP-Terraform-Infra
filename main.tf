provider "google" {
  credentials = file("terraform-sa-key.json")
  project     = var.project_id
  region      = var.region
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_name = var.vpc_name
  subnets  = var.subnets
  secondary_ip_range = var.secondary_ip_range
}

module "gke"{
  source = "./modules/gke"
  vpc_name = var.vpc_name
  subnet_name = var.subnets[1].name
  gke-pods = var.secondary_ip_range[0].range_name
  gke-services = var.secondary_ip_range[1].range_name
  subnet-two_range = var.subnets[1].cidr
  depends_on = [ module.vpc ]
}

module "documentation" {
  source      = "./modules/documentation"
  doc_content = <<EOT
This Terraform configuration sets up a custom VPC with multiple subnets across regions.

- Project ID: ${var.project_id}
- Region: ${var.region}
- VPC Name: ${var.vpc_name}
- Subnets:
%{for subnet in var.subnets~}
  - ${subnet.name} (${subnet.cidr}) in ${subnet.region}
%{endfor~}

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
  depends_on        = [module.documentation]
}

module "vm_instance" {
  source        = "./modules/vm"
  vm_instances = var.vm_instances
  # instance_name = each.key
  # machine_type  = each.value.machine_type
  # zone          = each.value.zone
  source_image  = var.source_image
  disk_size     = var.disk_size
  disk_type     = var.disk_type
  network       = var.network
  subnetwork    = var.subnetwork
  tags          = var.tags

  depends_on = [module.gcs_backend]

}

# Can be used for tracking (importing) vms created manually
# module "imported_vms" {
#   source     = "./modules/imported_vms"
#   depends_on = [ module.vm_instance ]
# }
