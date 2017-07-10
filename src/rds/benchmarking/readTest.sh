#!/bin/bash

./sysbench --test=tests/db/oltp.lua \
    --mysql-host=$DBHOST \
    --oltp-tables-count=250 \
    --mysql-user=$DBUSER \
    --mysqlpassword=$DBPASSWORD \
    --mysql-port=3306 \
    --db-driver=mysql \
    --oltp-tablesize=25000 \
    --mysql-db=$DBNAME \
    --max-requests=0 \
    --oltp_simple_ranges=0 \
    --oltp-distinct-ranges=0 \
    --oltp-sum-ranges=0 \
    --oltp-order-ranges=0 \
    --maxtime=600 \
    --oltp-read-only=on \
    --num-threads=500 run
    