#!/bin/bash
while [[ $# -gt 0 ]]; do
    case "$1" in --bucket|-b) BUCKET=$2 shift ;; --key|-k) KEY=$2 shift ;; *) echo "Invalid argument: $1" exit 1; esac
    shift
done
if [ -z "$BUCKET" ]; then BUCKET="123123123testtest"; fi
if [ -z "$KEY" ]; then KEY="backups"; fi

# Give access to all files in /data/backups
chmod -R 755 /data/backups

# Upload all files to s3
aws s3 cp /data/backups s3://$BUCKET/$KEY --recursive
