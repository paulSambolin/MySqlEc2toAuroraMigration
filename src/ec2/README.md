# MySQL server on ec2
1. MySqlEc2.yml - spins up an ec2 instance with mysql and percona innobackupex up installed
2. scripts/backup.sh - Venmo's backup and upload script
4. scripts/prepare.sh - given the directory of a backup, prepare the backup for restoration (not needed for restoration to aurora)
5. scripts/connect.sh - given database credentials, the name of a database, and the hostname of the host, connect to a remote mysql database using the mysql cli
6. scripts/DummyTablesAndData.sql - SQL script to populate the database with tables and data
7. scripts/replication-to-aurora.sh - a shell script that connects to a source mysql database and target aurora database to configure and start binlog replication
8. scripts/replication-to-mysql.sh - a shell script that connects to a source aurora database and target mysql database to configure and start binlog replication

# Deploy the ec2 instance
- Expects VPC resources from /rds/resources.yml to already be deployed to a stack named `resources`.  Override this default by specifying `-s <stack-name>` or `--stack <stack-name>`
`./scripts/deployMySqlEc2.sh`

## General connections
### Connect to remote ec2 instances
- Connect to remote ec2 instance
`ssh -i MySqlServerKeyPair.pem ec2-user@52.87.93.24`

### Connect to remote mysql db
- Connect to remote mysql db
`./connect -h 52.87.93.24`

## Create Backup and upload to s3
- Create the backup
`sudo /tmp/backup.sh`

- Record the lsn's from the output of the backup script
`xtrabackup: Transaction log of lsn (<LSN>) to (<LSN>) was copied.`

## Restore back to local mysql
### Prepare Backup
- Prepare the backup for restoration (must be ssh'd in)
`sudo /tmp/prepare.sh`

- Record the lsn from the output of the prepare script
`InnoDB: Shutdown completed; log sequence number <LSN>`

### Restore the backup
- Stop mysqld, delete the datadir and start the restoration
`sudo /tmp/restore.sh`
