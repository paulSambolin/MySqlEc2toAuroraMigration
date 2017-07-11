USE mysql;
CREATE DATABASE ParivedaTestDB;
GRANT ALL PRIVILEGES ON ParivedaTestDB.* TO 'ParivedaUser'@'%';
FLUSH PRIVILEGES;

USE ParivedaTestDB;

CREATE TABLE User (
        id INT NOT NULL,
        name VARCHAR(100),
        PRIMARY KEY (id)
);

INSERT INTO User
VALUES (1, 'User1'),
       (2, 'User2'),
       (3, 'User3');
