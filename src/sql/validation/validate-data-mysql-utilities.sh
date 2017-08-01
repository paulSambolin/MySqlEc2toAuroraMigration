#!/bin/bash

# Import configuration parameters

source config.cfg

# Prompt user for passwords

stty -echo
printf "Please enter password for source server.\nHost: $EC2_MYSQL_HOST \nUsername: $EC2_MYSQL_USER_NAME \nPassword: "
read EC2_MYSQL_PASSWORD
printf "\n"

stty -echo
printf "Please enter password for target server.\nHost: $AURORA_HOST \nUsername: $AURORA_USER_NAME \nPassword: "
read AURORA_PASSWORD
stty echo
printf "\n"

# Run schema compare tool

mysqldbcompare --server1=$EC2_MYSQL_USER_NAME:$EC2_MYSQL_PASSWORD@$EC2_MYSQL_HOST --server2=$AURORA_USER_NAME:$AURORA_PASSWORD@$AURORA_HOST $EC2_MYSQL_DATABASE:$AURORA_DATABASE --skip-diff --skip-object-compare –vv