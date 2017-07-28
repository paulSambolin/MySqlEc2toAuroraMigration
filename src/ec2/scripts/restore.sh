#!/bin/bash

# Stop mysqld
service mysqld stop

# Delete the datadir
rm -rf /var/lib/mysql

# Start the restoration
innobackupex --copy-back /data/backups

# Update the permissions of the datadir
chown -R mysql:mysql /var/lib/mysql

# Start mysqld
service mysqld start
