#!/bin/bash

source config.cfg

# Ship the current directory to the ec2 instance
scp -r -i ../ec2/MySqlServerKeyPair.pem . ec2-user@$EC2_MYSQL_HOST:/home/ec2-user/sql

# SSH in and run the script
ssh -i ../ec2/MySqlServerKeyPair.pem ec2-user@$EC2_MYSQL_HOST 'cd /home/ec2-user/sql && sudo chmod 755 replication-to-aurora.sh && ./replication-to-aurora.sh'
