#!/bin/bash
while [[ $# -gt 0 ]]; do
    case "$1" in --bucket|-b) BUCKET=$2 shift ;; --key|-k) KEY=$2 shift ;; --stack|-s) STACK=$2 shift ;; --config|-c) CONFIG=$2 shift ;; --template|-t) TEMPLATE=$2 shift ;; *) echo "Invalid argument: $1" exit 1; esac
    shift
done
if [ -z "$BUCKET" ]; then BUCKET="123123123testtest"; fi
if [ -z "$KEY" ]; then KEY="ip-172-31-25-24"; fi
if [ -z "$STACK" ]; then STACK="resources"; fi
if [ -z "$CONFIG" ]; then CONFIG="config.json"; fi
if [ -z "$TEMPLATE" ]; then TEMPLATE="resources-pre.yml"; fi

# Deploy the resources stack
aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --template-file $TEMPLATE --stack-name $STACK

# Get the outputs from the resource stack
CLUSTERPARAMETERGROUP=$(aws cloudformation list-exports --query 'Exports[?Name==`DBClusterParameterGroup-'$STACK'`].Value' --output text)
cat $CONFIG | jq --arg CLUSTERPARAMETERGROUP $CLUSTERPARAMETERGROUP '.DBClusterParameterGroupName = $CLUSTERPARAMETERGROUP' > newconfig.json  && mv newconfig.json $CONFIG

SUBNETGROUP=$(aws cloudformation list-exports --query 'Exports[?Name==`DBSubnetGroup-'$STACK'`].Value' --output text)
cat $CONFIG | jq --arg SUBNETGROUP $SUBNETGROUP '.DBSubnetGroupName = $SUBNETGROUP' > newconfig.json  && mv newconfig.json $CONFIG

SECURITYGROUP=$(aws cloudformation list-exports --query 'Exports[?Name==`SecurityGroup-'$STACK'`].Value' --output text)
cat $CONFIG | jq --arg SECURITYGROUP $SECURITYGROUP ".VpcSecurityGroupIds |= .+ [\"${SECURITYGROUP}\"]" > newconfig.json  && mv newconfig.json $CONFIG

AURORAROLEARN=$(aws cloudformation list-exports --query 'Exports[?Name==`AuroraRoleARN-'$STACK'`].Value' --output text)
cat $CONFIG | jq --arg AURORAROLEARN $AURORAROLEARN '.S3IngestionRoleArn = $AURORAROLEARN' > newconfig.json  && mv newconfig.json $CONFIG

PRIMARYAZ=$(aws cloudformation list-exports --query 'Exports[?Name==`PrimaryAZ-'$STACK'`].Value' --output text)
cat $CONFIG | jq --arg PRIMARYAZ $PRIMARYAZ ".AvailabilityZones |= .+ [\"${PRIMARYAZ}\"]" > newconfig.json  && mv newconfig.json $CONFIG

SECONDARYAZ=$(aws cloudformation list-exports --query 'Exports[?Name==`SecondaryAZ-'$STACK'`].Value' --output text)
cat $CONFIG | jq --arg SECONDARYAZ $SECONDARYAZ ".AvailabilityZones |= .+ [\"${SECONDARYAZ}\"]" > newconfig.json  && mv newconfig.json $CONFIG

cat $CONFIG | jq --arg BUCKET $BUCKET '.S3BucketName = $BUCKET' > newconfig.json  && mv newconfig.json $CONFIG

cat $CONFIG | jq --arg KEY $KEY '.S3Prefix = $KEY' > newconfig.json  && mv newconfig.json $CONFIG

#  Restore the cluster from s3
aws rds restore-db-cluster-from-s3 --cli-input-json file://`pwd`/$CONFIG > clusterOutput.json

# Create DB instances and associate with the DBCluster (use a different config)
# PARAMETERGROUP=$(aws cloudformation list-exports --query 'Exports[?Name==`DBClusterParameterGroup-'$STACK'`].Value' --output text)
# cat $CONFIG | jq --arg PARAMETERGROUP $PARAMETERGROUP '.DBClusterParameterGroupName = $CLUSTERPARAMETERGROUP' > newconfig.json  && mv newconfig.json $CONFIG