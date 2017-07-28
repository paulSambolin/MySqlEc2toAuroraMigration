#!/bin/bash
while [[ $# -gt 0 ]]; do
    case "$1" in --bucket|-b) BUCKET=$2 shift ;; --key|-k) KEY=$2 shift ;; --stack|-s) STACK=$2 shift ;; --clusterName|-cn) CLUSTERNAME=$2 shift ;; --instanceName|-in) INSTANCENAME=$2 shift ;; --clusterConfig|-cc) CLUSTERCONFIG=$2 shift ;; --instanceConfig|-ic) INSTANCECONFIG=$2 shift ;; *) echo "Invalid argument: $1" exit 1; esac
    shift
done
if [ -z "$BUCKET" ]; then BUCKET="123123123testtest"; fi
if [ -z "$KEY" ]; then KEY="ip-10-0-1-107"; fi
if [ -z "$STACK" ]; then STACK="resources"; fi
if [ -z "$CLUSTERNAME" ]; then CLUSTERNAME="aurora"; fi
if [ -z "$INSTANCENAME" ]; then INSTANCENAME="aurora2"; fi
if [ -z "$CLUSTERCONFIG" ]; then CLUSTERCONFIG="clusterConfig.json"; fi
if [ -z "$INSTANCECONFIG" ]; then INSTANCECONFIG="instanceConfig.json"; fi

# Get the outputs from the resource stack and prepare cluster config
CLUSTERPARAMETERGROUP=$(aws cloudformation list-exports --query 'Exports[?Name==`DBClusterParameterGroup-'$STACK'`].Value' --output text)
cat $CLUSTERCONFIG | jq --arg CLUSTERPARAMETERGROUP $CLUSTERPARAMETERGROUP '.DBClusterParameterGroupName = $CLUSTERPARAMETERGROUP' > newconfig.json  && mv newconfig.json $CLUSTERCONFIG

SUBNETGROUP=$(aws cloudformation list-exports --query 'Exports[?Name==`DBSubnetGroup-'$STACK'`].Value' --output text)
cat $CLUSTERCONFIG | jq --arg SUBNETGROUP $SUBNETGROUP '.DBSubnetGroupName = $SUBNETGROUP' > newconfig.json  && mv newconfig.json $CLUSTERCONFIG

SECURITYGROUP=$(aws cloudformation list-exports --query 'Exports[?Name==`SecurityGroup-'$STACK'`].Value' --output text)
cat $CLUSTERCONFIG | jq --arg SECURITYGROUP $SECURITYGROUP ".VpcSecurityGroupIds |= .+ [\"${SECURITYGROUP}\"]" > newconfig.json  && mv newconfig.json $CLUSTERCONFIG

AURORAROLEARN=$(aws cloudformation list-exports --query 'Exports[?Name==`AuroraRoleARN-'$STACK'`].Value' --output text)
cat $CLUSTERCONFIG | jq --arg AURORAROLEARN $AURORAROLEARN '.S3IngestionRoleArn = $AURORAROLEARN' > newconfig.json  && mv newconfig.json $CLUSTERCONFIG

PRIMARYAZ=$(aws cloudformation list-exports --query 'Exports[?Name==`PrimaryAZ-'$STACK'`].Value' --output text)
cat $CLUSTERCONFIG | jq --arg PRIMARYAZ $PRIMARYAZ ".AvailabilityZones |= .+ [\"${PRIMARYAZ}\"]" > newconfig.json  && mv newconfig.json $CLUSTERCONFIG

SECONDARYAZ=$(aws cloudformation list-exports --query 'Exports[?Name==`SecondaryAZ-'$STACK'`].Value' --output text)
cat $CLUSTERCONFIG | jq --arg SECONDARYAZ $SECONDARYAZ ".AvailabilityZones |= .+ [\"${SECONDARYAZ}\"]" > newconfig.json  && mv newconfig.json $CLUSTERCONFIG

cat $CLUSTERCONFIG | jq --arg BUCKET $BUCKET '.S3BucketName = $BUCKET' > newconfig.json  && mv newconfig.json $CLUSTERCONFIG

cat $CLUSTERCONFIG | jq --arg KEY $KEY '.S3Prefix = $KEY' > newconfig.json  && mv newconfig.json $CLUSTERCONFIG

cat $CLUSTERCONFIG | jq --arg CLUSTERNAME $CLUSTERNAME '.DBClusterIdentifier = $CLUSTERNAME' > newconfig.json  && mv newconfig.json $CLUSTERCONFIG

# #  Restore the cluster from s3
aws rds restore-db-cluster-from-s3 --cli-input-json file://`pwd`/$CLUSTERCONFIG > clusterOutput.json

# Create DB instances and associate with the DBCluster (use a different config)
PARAMETERGROUP=$(aws cloudformation list-exports --query 'Exports[?Name==`DBParameterGroup-'$STACK'`].Value' --output text)
cat $INSTANCECONFIG | jq --arg PARAMETERGROUP $PARAMETERGROUP '.DBParameterGroupName = $PARAMETERGROUP' > newconfig.json  && mv newconfig.json $INSTANCECONFIG

cat $INSTANCECONFIG | jq --arg SUBNETGROUP $SUBNETGROUP '.DBSubnetGroupName = $SUBNETGROUP' > newconfig.json  && mv newconfig.json $INSTANCECONFIG

cat $INSTANCECONFIG | jq --arg CLUSTERNAME $CLUSTERNAME '.DBClusterIdentifier = $CLUSTERNAME' > newconfig.json  && mv newconfig.json $INSTANCECONFIG

cat $INSTANCECONFIG | jq --arg INSTANCENAME $INSTANCENAME '.DBInstanceIdentifier = $INSTANCENAME' > newconfig.json  && mv newconfig.json $INSTANCECONFIG

aws rds create-db-instance --cli-input-json file://`pwd`/$INSTANCECONFIG > instanceOutput.json