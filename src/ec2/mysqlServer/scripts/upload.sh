#!/bin/bash
while [[ $# -gt 0 ]]; do
    case "$1" in --bucket|-b) BUCKET=$2 shift ;; --key|-k) KEY=$2 shift ;; *) echo "Invalid argument: $1" exit 1; esac
    shift
done
if [ -z "$BUCKET" ]; then BUCKET="123testtestbucket"; fi
if [ -z "$KEY" ]; then KEY="backups"; fi
for filename in /data/backups/*.tar.gz; do s3cmd put "$filename" s3://$BUCKET/$KEY"$filename" --verbose; done
