# MySQL server on ec2
1. MySqlEc2.yml - spins up an ec2 instance with mysql and percona xtra back up installed
2. backup.sh - given database credentials, a database name, and an s3 bucket create a backup of the database and upload to s3
3. DummyTablesAndData.sql - SQL script to populate the database with tables and data


- Connect to ec2 instance
`ssh -i MySqlServerKeyPair.pem ec2-user@52.87.93.24`

- Connect to mysql db using the mysql utility
`mysql -h localhost -u ParivedaUser -pPariveda1 ParivedaTestDB`
`./connect -h 52.87.93.24`
