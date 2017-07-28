1. `resources.yml` - Cloudformation script for spinning up resources needed for the aurora restoration:
  - VPC (Venmo)
  - Subnets (Venmo)
  - Database Subnet Group (Venmo)
  - Security Group (Venmo)
  - IAM Role (Venmo)
  - Database Cluster Parameter Group (Pariveda)
  - Database Parameter Group (Pariveda)
2. `deployResources.sh` - script for deploying the resources template