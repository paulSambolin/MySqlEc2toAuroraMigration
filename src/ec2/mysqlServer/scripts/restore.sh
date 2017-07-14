#!/bin/bash

# Stop mysqld
service mysqld stop

# Delete the datadir
rm -rf /data/backups

# Start the restoration
xtrabackup --copy-back --target-dir=/data/backups

# Update the permissions of the datadir
chown -R mysql:mysql /var/lib/mysql

# Start mysqld
service mysqld start
