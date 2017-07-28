#!/bin/bash
# Set up mysql binary log replication based on given config file (config file name passed in in $1)

# Import configuration parameters

source config.cfg

# Create appropriate user on Source DB (EC2 MySQL)

echo "GRANT REPLICATION SLAVE ON *.* TO '$AURORA_SLAVE_USER_NAME'@'%' IDENTIFIED BY '$AURORA_SLAVE_PASSWORD';
      FLUSH PRIVILEGES;" | $AURORA_MYSQL

# Set up external master on Target DB (Aurora)
# There seems to be a limit to the length of MASTER_HOST for this command, keep an eye out for connection errors

echo "CHANGE MASTER TO MASTER_HOST='$AURORA_HOST',MASTER_USER='$AURORA_SLAVE_USER_NAME', MASTER_PASSWORD='$AURORA_SLAVE_PASSWORD', MASTER_LOG_FILE='mysql-bin.000010', MASTER_LOG_POS=  110996594;
      START SLAVE;
      SHOW SLAVE STATUS\G" | $EC2_MYSQL

