# Restore DB Cluster from S3
This folder contains everything needed to restore a DB Cluster from a mysql backup in s3

1. `config.json` - The config file contains all of the options needed to restore the backup from s3
2. `resources-pre.yml` - Cloudformation script for spinning up resources needed for the aurora restoration:
  - VPC (Venmo)
  - Subnets (Venmo)
  - Database Subnet Group (Venmo)
  - Security Group (Venmo)
  - Database Cluster Parameter Group (Pariveda)
  - Database Parameter Group (Pariveda)

3. `restoreFromS3.sh` - Restores the database from s3 to aurora
  - deploys the cloudformation stack resources-pre.yml
  - call the awscli to restore-db-cluster-from-s3 and pass the config options from config.json
  - deploy the post resoureces

3. `resources-post.yml` - Cloudformation script for spinning up resources needed after the aurora restoration
  - Cloudwatch alarms
