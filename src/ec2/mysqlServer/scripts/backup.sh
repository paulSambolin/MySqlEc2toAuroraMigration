#!/bin/bash
# Update mysql user group permissons
chown -R mysql: /var/lib/mysql
find /var/lib/mysql -type d -exec chmod 775 "{}" \;
# Create the backup
xtrabackup --backup --user=ParivedaUser --password=Pariveda1 --no-timestamp --target-dir=/data/backups --stream=tar | gzip - | split -d --bytes=512000 - /data/backups/backup.tar.gz
