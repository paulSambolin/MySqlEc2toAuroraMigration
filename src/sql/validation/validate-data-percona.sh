#!/bin/bash

# Import configuration parameters

source config.cfg

# Prompt user for passwords

stty -echo
printf "Please enter password for source server.\nHost: $EC2_MYSQL_HOST \nUsername: $EC2_MYSQL_USER_NAME \nPassword: "
read EC2_MYSQL_PASSWORD
stty echo
printf "\n"

# Run schema compare tool

pt-table-checksum -h $EC2_MYSQL_HOST -u $EC2_MYSQL_USER_NAME -p $EC2_MYSQL_PASSWORD --databases $EC2_MYSQL_DATABASE --no-check-binlog-format --no-check-replication-filters