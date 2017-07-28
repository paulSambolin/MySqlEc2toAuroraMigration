#!/bin/bash
set -o errexit -o nounset -o pipefail -o xtrace
# Update mysql user group permissons
chown -R mysql: /var/lib/mysql
find /var/lib/mysql -type d -exec chmod 775 "{}" \;
# Create the backup
SNAPDATE="$(date +"%FT%H-%M")"
BACKUP_DIR="/var/lib/mysql/tmp/backup"
TMP_DIR="/var/lib/mysql/tmp"
S3_BUCKET="123123123testtest"
LOG="/var/log/mysql_snapshot.log"
GOF3R="/home/ec2-user/go/bin/gof3r"
GOF3R_ARGS="--concurrency 64 --partsize 52428800 --header x-amz-server-side-encryption:AES256"
INNOBACKUPEX="/usr/bin/innobackupex"
S3_PATH="${HOSTNAME}/${SNAPDATE}-${HOSTNAME}.tar.gz"
S3_URL="s3://${S3_BUCKET}/${S3_PATH}"
echo "$(date +"%b %d %T") Starting backup" >> $LOG
$INNOBACKUPEX --lock-wait-timeout=300 --no-timestamp --safe-slave-backup --slave-info --stream=tar --user=${DBUsername} --password=${DBPassword} --tmpdir=${TMP_DIR} $BACKUP_DIR 2>> $LOG | pigz -p 64 | $GOF3R put $GOF3R_ARGS -b $S3_BUCKET -k $S3_PATH >> $LOG 2>&1
echo "$(date +"%b %d %T") Backup complete, S3 URL is ${S3_URL}" >> $LOG
