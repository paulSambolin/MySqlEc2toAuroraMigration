#!/bin/bash

while [[ $# -gt 0 ]]; do
    case "$1" in
    --host|-h)
        HOST=$2
        shift
        ;;
    --calls|-c)
        CALLS=$2
        shift
        ;;
    *)
        echo "Invalid argument: $1"
        exit 1
    esac
    shift
done

COUNTER=0
while [  $COUNTER -lt $CALLS ]; do
    curl -X PUT -i -H "Content-type: application/json" -X GET $HOST
    echo The counter is $COUNTER
    let COUNTER=COUNTER+1 
done
