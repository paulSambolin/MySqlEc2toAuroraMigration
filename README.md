# MySqlEc2toAuroraMigration
Practice for a mysql migration from an ec2 instance to aws aurora


1. deploy the resources template in resources/resources.yml (maybe move to separate folder and create readme)
`./resources/deployResources.sh`
2. deploy the MySqlEc2.yml template into the vpc/subnets created by resources (should populate values by default or override with the name of the resource CF stack in the parameter ResourceTemplate)
  - Follow the instructions in ec2/README.md
3. create a backup from ec2
  - Follow the instructions in ec2/README.md
4. Restore to aurora in the same vpc
  - Follow the instructions in rds/restoreFromS3/README.md
5. setup replication between ec2 and aurora
  - Follow instructions in sql/README.md
6. Monitor replicaiton lag and send to cloudwatch
7. 