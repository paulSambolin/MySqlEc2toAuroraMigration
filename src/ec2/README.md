1. Install MySQL
- NOTE: after installing mysql you need to create a new user with permissions and restart mysql in order to connect to the server with the mysql utility from a remote machine.  The default permissions force you to ssh into the instance before you can use the mysql utility to connect to local host

- Connect to ec2 instance
`ssh -i MySqlServerKeyPair.pem ec2-user@52.87.93.24`

- Install mysql
```bash
yum install wget -y
wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
rpm -ivh mysql-community-release-el6-5.noarch.rpm
yum install mysql-server -y
/etc/init.d/mysqld start
```

- Configure mysql, database, and remote user
```bash
mysql -u root
```
```sql
CREATE DATABASE ParivedaTestDB;
use ParivedaTestDB;
UPDATE user SET password=PASSWORD("Pariveda1") WHERE User='root';
CREATE USER 'ParivedaUser'@'localhost' IDENTIFIED BY 'Pariveda1';
GRANT ALL PRIVILEGES ON *.* TO 'ParivedaUser'@'localhost' WITH GRANT OPTION;
CREATE USER 'ParivedaUser'@'%' IDENTIFIED BY 'Pariveda1';
GRANT ALL PRIVILEGES ON *.* TO 'ParivedaUser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
quit;
```

- Connect to mysql db using the mysql utility
`mysql -h localhost -u ParivedaUser -pPariveda1 ParivedaTestDB`

2. Install Percona
```bash
yum --enablerepo=epel install libev -y
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-4/percona-release-0.1-4.noarch.rpm -y
yum install percona-xtrabackup-24
```

#Notes on percona different software offerings:
- Percona Server - enhanced drop in replacement for mysql
- Percona xtra backup - hot (ie. active) backup utility for mysql
- Percona toolkit - collection of advanced command line tools used to perform a variety of complex tasks

3. Fill with dummy data
DELIMITER $$
BEGIN
  DECLARE i INT DEFAULT 100;

  WHILE i < 100000 DO
    INSERT INTO testtable (val) VALUES (i);
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;


