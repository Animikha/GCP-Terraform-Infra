## Description
This Terraform project provisions a comprehensive Google Cloud Platform (GCP) infrastructure. It includes modules for:
- VPC
- VM Instances
- Google Cloud Storage (GCS)
- Google Kubernetes Engine (GKE)
- MySQL Database
- Auto-generated Documentation
---
### VPC
#### Overview
This Terraform module provisions a **custom Virtual Private Cloud (VPC)** in Google Cloud with multiple subnets and firewall rules to support secure and segmented networking for other infrastructure components like VM instances, GKE clusters, and more.

#### Key Features
1. **Custom VPC Creation**
   - VPC name is configurable via `var.vpc_name`.
   - `auto_create_subnetworks = false` ensures manual control over subnet creation.
   - Regional routing mode for optimized traffic flow within the region.

2. **Subnets**
   - Multiple subnets are provisioned using a list of maps passed via `var.subnets`.
   - Each subnet includes:
     - Custom CIDR block
     - Region-specific deployment

3. **Firewall Rules**
   - **Internal Access**: Allows ICMP, SSH (22), HTTP (80), and HTTPS (443) within the VPC
   - **External Access**:
     - SSH access from the internet for instances tagged with `ssh-access`.
     - HTTP access for instances tagged with `web`.
     - HTTPS access for instances tagged with `secure-web`.
#### Security Considerations
- Tag-based firewall rules ensure that only intended instances receive external traffic.
- Ingress rules are tightly scoped to minimize exposure.

### VM

### GCS

### Google Kubernetes Engine (GKE) Cluster
#### Overview
This Terraform configuration provisions a private Google Kubernetes Engine (GKE) cluster in the asia-south1 region, designed with strong security and controlled network access.

Key Characteristics:
1. Cluster Type:
   - Private cluster — Nodes do not have public IP addresses (`enable_private_nodes = true`)
   - Kubernetes control plane is private endpoint only (`enable_private_endpoint = true`), which means the API server is only accessible from inside the VPC

2. Networking:
   - Integrated with an existing VPC and subnetwork specified by variables (`var.vpc_name, var.subnet_name`)
   - Uses IP aliasing (`ip_allocation_policy`) with dedicated secondary IP ranges for Pods and Services
   - Access to the control plane is restricted by master authorized networks to only one CIDR block (`var.subnet-two_range`)

3. Security Features:
   - Shielded nodes enabled (`enable_shielded_nodes = true`)
   - Secure Boot and integrity monitoring turned on for node instances
   - Master authorized networks used to restrict API access to specific IP ranges

4. Node Configuration:
   - Machine type: e2-medium (2 vCPU, 4 GB RAM)
   - Smaller-than-default disk size (15GB) to save cost, using standard persistent disk (pd-standard)
   - Full cloud-platform OAuth scope for GCP API access.

5. Operational Settings:
   - Single initial node (`initial_node_count = 1`)
   - Release channel: REGULAR (automatic version updates with regular cadence)
   - Deletion protection disabled (`deletion_protection = false`) for easy teardown in dev/test environments.


### MySQL Database
---
### Documentation
#### Overview
This module generates a local documentation file summarizing the Terraform infrastructure that has been provisioned. It is designed to run **after all other modules** have completed successfully, ensuring that the documentation reflects the final state of the infrastructure.
#### Key Features
- **Local File Generation**: Uses the `local_file` resource to create a `.txt` file containing dynamically rendered content.
- **Content Customization**: The documentation content is passed via the `doc_content` variable, allowing templated descriptions of resources like VPC, subnets, and project metadata.
- **Output Location**: The file is saved at the root level of the project as `terraform_documentation.txt`.

