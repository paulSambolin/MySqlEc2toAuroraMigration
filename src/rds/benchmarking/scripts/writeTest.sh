#!/bin/bash
cd /sysbench/sysbench
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
    --max-time=600 \
    --oltp_simple_ranges=0 \
    --oltp-distinct-ranges=0 \
    --oltp-sum-ranges=0 \
    --oltporder-ranges=0 \
    --oltp-point-selects=0 \
    --num-threads=1000 \
    --randtype=uniform \
    run
