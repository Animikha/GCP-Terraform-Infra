# // Uncomment and run this only after provisioning the gcs and other resources, 
# // Otherwise keep this file commented while running terraform init for the first time
# // Also comment out this first and do terraform init before running terraform destroy
# terraform {
#   backend "gcs" {
#     bucket  = "bucket-one-0608251030"           # Must match the actual bucket name
#     prefix  = "terraform/state"   # Folder path inside the bucket
#     credentials = "terraform-sa-key.json"
#   }
# }
