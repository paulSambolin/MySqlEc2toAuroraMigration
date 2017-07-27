# Restore DB Cluster from S3
This folder contains everything needed to restore a DB Cluster from a mysql backup in s3

### Questions
Is data encrypted using a kms key?  If so you can unencrypt it as we restore to save time.  If encryption is not handled by kms then StorageEncrypted=false

### Prerequisites
1. The machine you run this restore script from (preferably the bastion host) must have jq installed in order to generate json on the fly
2. " " must have all the files in ./ 

### Files
1. `resources.yml` - Cloudformation script for spinning up resources needed for the aurora restoration:
  - VPC (Venmo)
  - Subnets (Venmo)
  - Database Subnet Group (Venmo)
  - Security Group (Venmo)
  - IAM Role (Venmo)
  - Database Cluster Parameter Group (Pariveda)
  - Database Parameter Group (Pariveda)

2. `restoreFromS3.sh` - Restores the database from s3 to aurora
  - deploys the cloudformation stack resources.yml
  - call the awscli to restore-db-cluster-from-s3 and pass the config options from config.json
  - deploy the post resoureces

3. `clusterConfig.json` - Contains the config for the db cluster.  Parameters are populated by the script
4. `instanceConfig.json` - Contains the config for the db instance.  Parameters are populated by the script

5. `clusterOutput.json` - Contains the output for the db cluster
6. `instanceOutput.json` - Contains the output for the db instance
