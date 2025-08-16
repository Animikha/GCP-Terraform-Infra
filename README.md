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
---
### VM
#### Overview
This module provisions one or more **Google Compute Engine VM instances** using a dynamic configuration approach via the `for_each` construct. Each VM is uniquely defined by its name, machine type, zone, and other customizable parameters.

#### Key Features
1. **Dynamic Instance Creation**
   - Uses `for_each` to create multiple VM instances based on the `var.vm_instances` map.
   - Each instance is uniquely named using the map key.

2. **Machine Configuration**
   - Machine type and zone are configurable per instance.
   - Boot disk parameters include:
     - Source image (`var.source_image`)
     - Disk size (`var.disk_size`)
     - Disk type (`var.disk_type`)

3. **Networking**
   - Each VM is attached to a specified VPC and subnetwork.
   - External IP is enabled via `access_config {}`.
   - Network tags (`var.tags`) are used for firewall rule targeting.

4. **Startup Script**
   - Each VM is provisioned with a **startup script** that ensures the MySQL client is installed
   - On SSH login, the terminal session automatically launches the **MySQL database console** connected to the Cloud SQL instance
   - This allows immediate interaction with the database without requiring manual commands 

---
### GCS
#### Overview
This module provisions a **Google Cloud Storage (GCS) bucket** to serve as a backend or general-purpose storage resource for the infrastructure. It includes lifecycle management and versioning features for better data governance and cost control.

#### Key Features
1. **Bucket Configuration**
   - Bucket name, location, and project are configurable via variables.
   - Uniform bucket-level access is enabled for simplified IAM management.
   - `force_destroy = true` allows the bucket to be deleted even if it contains objects.

2. **Versioning**
   - Object versioning is optionally enabled via `var.enable_versioning`.
   - Helps retain historical versions of objects for recovery and auditing.

3. **Lifecycle Rules**
   - Automatically deletes objects older than 30 days to manage storage costs.
   - Configurable via the `lifecycle_rule` block.
---
### Google Kubernetes Engine (GKE) Cluster
#### Overview
This Terraform configuration provisions a private Google Kubernetes Engine (GKE) cluster in the asia-south1 region, designed with strong security and controlled network access.


#### Key Characteristics:
**1. Cluster Type:**
   - Private cluster — Nodes do not have public IP addresses (`enable_private_nodes = true`)
   - Kubernetes control plane is private endpoint only (`enable_private_endpoint = true`), which means the API server is only accessible from inside the VPC

**2. Networking:**
   - Integrated with an existing VPC and subnetwork specified by variables (`var.vpc_name, var.subnet_name`)
   - Uses IP aliasing (`ip_allocation_policy`) with dedicated secondary IP ranges for Pods and Services
   - Access to the control plane is restricted by master authorized networks to only one CIDR block (`var.subnet-two_range`)

**3. Security Features:**
   - Shielded nodes enabled (`enable_shielded_nodes = true`)
   - Secure Boot and integrity monitoring turned on for node instances
   - Master authorized networks used to restrict API access to specific IP ranges

**4. Node Configuration:**
   - Machine type: e2-medium (2 vCPU, 4 GB RAM)
   - Smaller-than-default disk size (15GB) to save cost, using standard persistent disk (pd-standard)
   - Full cloud-platform OAuth scope for GCP API access.

**5. Operational Settings:**
   - Single initial node (`initial_node_count = 1`)
   - Release channel: REGULAR (automatic version updates with regular cadence)
   - Deletion protection disabled (`deletion_protection = false`) for easy teardown in dev/test environments.

---
## Cloud SQL (MySQL)

### Overview  
This Terraform configuration provisions a **Google Cloud SQL MySQL instance** that is accessible only through a **Private Service Connection (PSC)** within a custom VPC network.  
It ensures that the database is private, secure, and integrated with controlled VPC access.  

### Key Characteristics  

**1. Networking** 
- Creates a **reserved internal IP range** (`google_compute_global_address`) dedicated for PSC.  
- Establishes a **private VPC service networking connection** (`google_service_networking_connection`) between the custom VPC and Google-managed services.  
- Cloud SQL is provisioned with **private IP only** (`ipv4_enabled = false`).  
- Database access is restricted to workloads inside the same VPC.  


**2. Cloud SQL Instance**  
- **Engine**: MySQL (version defined via `var.db_version`).  
- **Region**: Configurable (`var.region`).  
- **Tier**: Machine type defined via `var.db_tier`.  
- **Edition**: Configurable (`var.sql_edition`).  
- **Availability**: High availability or single-zone, controlled by `var.db_availability_type`.  
- **Disk**: Standard or SSD, with autoscaling enabled.  
- **Backups**: Daily backups, binary logging, and transaction log retention configured.  
- **Maintenance**: Controlled by `var.db_maintenance_day` and `var.db_maintenance_hour`.  

 **3. Security Features**  
- No public IPs assigned (private only).  
- Database access restricted to internal VPC traffic.  
- **Deletion protection** can be enabled/disabled via variable (`var.db_deletion_protection_enabled`).  
- Automated backups and logs improve recovery and auditability.  

**4. Database & User Configuration**  
- **Database user** created with username (`var.db_user`) and password (`var.db_password`).  
- **Default database** created (`var.db_name`).  

**5. Operational Settings**  
- **Deletion protection disabled by default** for easy teardown in dev/test environments.  
- **Disk autoscaling enabled** to avoid manual resizing.  
- Configuration is modular with variables for flexibility across environments.  

---
### Documentation
#### Overview
This module generates a local documentation file summarizing the Terraform infrastructure that has been provisioned. It is designed to run **after all other modules** have completed successfully, ensuring that the documentation reflects the final state of the infrastructure.
#### Key Features
- **Local File Generation**: Uses the `local_file` resource to create a `.txt` file containing dynamically rendered content.
- **Content Customization**: The documentation content is passed via the `doc_content` variable, allowing templated descriptions of resources like VPC, subnets, and project metadata.
- **Output Location**: The file is saved at the root level of the project as `terraform_documentation.txt`.

