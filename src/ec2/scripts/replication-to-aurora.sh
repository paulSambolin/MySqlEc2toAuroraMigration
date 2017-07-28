#!/bin/bash
# Set up mysql binary log replication based on given config file (config file name passed in in $1)

# Import configuration parameters

source config.cfg

# Create appropriate user on Source DB (EC2 MySQL)

echo "GRANT REPLICATION SLAVE ON *.* TO '$EC2_MYSQL_SLAVE_USER_NAME'@'%' IDENTIFIED BY '$EC2_MYSQL_SLAVE_PASSWORD';
      FLUSH PRIVILEGES;" | $EC2_MYSQL

# Set up external master on Target DB (Aurora)

echo "CALL mysql.rds_set_external_master ('$EC2_MYSQL_HOST', 3306, '$EC2_MYSQL_SLAVE_USER_NAME', '$EC2_MYSQL_SLAVE_PASSWORD', 'mysql-bin.000003', 120, 0);
      CALL mysql.rds_start_replication;
      SHOW SLAVE STATUS\G" | $AURORA_MYSQL