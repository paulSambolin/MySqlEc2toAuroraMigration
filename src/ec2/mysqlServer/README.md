# MySQL server on ec2
1. MySqlEc2.yml - spins up an ec2 instance with mysql and percona xtra back up installed
2. scripts/backup.sh - given database credentials, a database name, and an s3 bucket create a backup of the database and upload to s3
3. scripts/prepare.sh - prepare the backup for restoration (local only, not needed for restoration to aurora)
4. scripts/connect.sh - connect to a remote mysql database using the mysql cli
3. DummyTablesAndData.sql - SQL script to populate the database with tables and data

### Connect to remote instances
- Connect to ec2 instance
`ssh -i MySqlServerKeyPair.pem ec2-user@52.87.93.24`

### Create Backup
- Create the backup
`sudo /tmp/backup.sh`

- Record the lsn's from the output of the backup script
`xtrabackup: Transaction log of lsn (<LSN>) to (<LSN>) was copied.`

### Prepare Backup
- Prepare the backup for restoration
`sudo /tmp/prepare.sh`

- Record the lsn from the output of the prepare script
`InnoDB: Shutdown completed; log sequence number <LSN>`

### Restore the backup
- Stop mysqld, delete the datadir and start the restoration
`sudo /tmp/restore.sh`

- Connect to remote mysql db
`./connect -h 52.87.93.24`


