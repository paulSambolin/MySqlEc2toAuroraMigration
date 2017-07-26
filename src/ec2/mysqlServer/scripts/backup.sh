#!/bin/bash
# Update mysql user group permissons
chown -R mysql: /var/lib/mysql
find /var/lib/mysql -type d -exec chmod 775 "{}" \;
# Create the backup
innobackupex --user=$DBUsername --password=$DBPassword --no-timestamp /data/backups
