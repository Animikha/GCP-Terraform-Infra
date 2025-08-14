## Description

### VPC

### VM

### GCS

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


### MySQL Database

### Documentation
