#!/bin/bash
while [[ $# -gt 0 ]]; do
    case "$1" in
    --host|-h)
        HOST=$2
        shift
        ;;
    --dbname|-db)
        DBNAME=$2
        shift
        ;;
    -username|-u)
        USERNAME=$2
        shift
        ;;
    -password|-p)
        PASSWORD=$2
        shift
        ;;
    *)
        echo "Invalid argument: $1"
        exit 1
    esac
    shift
done

if [ -z "$HOST" ]; then
    echo "Host IP address required"
    exit 1
fi
if [ -z "$DBNAME" ]; then
    DBNAME="ParivedaTestDB"
fi
if [ -z "$USERNAME" ]; then
    USERNAME="ParivedaUser"
fi
if [ -z "$PASSWORD" ]; then
    PASSWORD="Pariveda1"
fi

mysql -h $HOST -u $USERNAME -p$PASSWORD $DBNAME