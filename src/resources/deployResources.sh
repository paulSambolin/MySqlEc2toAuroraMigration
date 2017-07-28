#!/bin/bash
while [[ $# -gt 0 ]]; do
    case "$1" in --stack|-s) STACK=$2 shift ;; --template|-t) TEMPLATE=$2 shift ;; *) echo "Invalid argument: $1" exit 1; esac
    shift
done
if [ -z "$STACK" ]; then STACK="tec2"; fi
if [ -z "$TEMPLATE" ]; then TEMPLATE="../MySqlEc2.yml"; fi

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --template-file $TEMPLATE --stack-name $STACK
