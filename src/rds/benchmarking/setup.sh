#!/bin/bash

./sysbench --test=tests/db/oltp.lua \
    --mysql-host=$DBHOST \
    --mysql-port=3306 \
    --mysql-user=$DBUSER \
    --mysqlpassword=$DBPASSWORD \
    --mysql-db=$DBNAME \
    --mysql-table-engine=innodb \
    --oltp-table-size=25000 \
    --oltp-tables-count=250 \
    --db-driver=mysql prepare
    