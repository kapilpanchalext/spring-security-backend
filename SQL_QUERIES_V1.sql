CREATE SCHEMA `spring_security_1`;

create table users(username varchar(50) not null primary key,password varchar(500) not null,enabled boolean not null);
create table authorities (username varchar(50) not null,authority varchar(50) not null,constraint fk_authorities_users foreign key(username) references users(username));
create unique index ix_auth_username on authorities (username,authority);

INSERT IGNORE INTO `users` VALUES ('user', '{noop}1234', '1');
INSERT IGNORE INTO `authorities` VALUES ('user', 'read');

INSERT IGNORE INTO `users` VALUES ('admin', '{bcrypt}$2a$12$IfcYJIF5PpE.BcKTUX2Ym.c9E/WLCkY3SfktPW6epyETO62eS.qj6', '1');
INSERT IGNORE INTO `authorities` VALUES ('admin', 'admin');

SELECT `authorities`.`username`,
    `authorities`.`authority`
FROM `spring_security_1`.`authorities`;

SELECT `users`.`username`,
    `users`.`password`,
    `users`.`enabled`
FROM `spring_security_1`.`users`;

CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `pwd` VARCHAR(200) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
);

SELECT `student`.`id`,
    `student`.`student_id`,
    `student`.`email`,
    `student`.`pwd`,
    `student`.`role`
FROM `spring_security_1`.`student`;

INSERT INTO `spring_security_1`.`student`(`student_id`,`email`,`pwd`,`role`)VALUES(1111111111,'student1@email.com','{bcrypt}$2a$12$IfcYJIF5PpE.BcKTUX2Ym.c9E/WLCkY3SfktPW6epyETO62eS.qj6','read');
INSERT INTO `spring_security_1`.`student`(`student_id`,`email`,`pwd`,`role`)VALUES(1111111112,'admin@email.com','{bcrypt}$2a$12$IfcYJIF5PpE.BcKTUX2Ym.c9E/WLCkY3SfktPW6epyETO62eS.qj6','admin');

SELECT `student`.`id`,
    `student`.`student_id`,
    `student`.`email`,
    `student`.`pwd`,
    `student`.`role`
FROM `spring_security_1`.`student`;

DROP TABLE authorities;
DROP TABLE student;
DROP TABLE users;

CREATE TABLE `student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile_number` varchar(20) NOT NULL,
  `pwd` varchar(500) NOT NULL,
  `role` varchar(100) NOT NULL,
  `create_dt` date DEFAULT NULL,
  PRIMARY KEY (`student_id`)
);

INSERT INTO `student` (`name`,`email`,`mobile_number`, `pwd`, `role`,`create_dt`)
VALUES ('Admin','admin@email.com','5334122365', '{bcrypt}$2a$12$l9wCAipRmOhukTrkiEQKvOgA85AIbFqmvlA11SZOqgTuSmy1CwHOK', 'admin', CURDATE());
 
SELECT `student`.`student_id`,
    `student`.`name`,
    `student`.`email`,
    `student`.`mobile_number`,
    `student`.`pwd`,
    `student`.`role`,
    `student`.`create_dt`
FROM `spring_security_1`.`student`;

CREATE TABLE `authorities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `authorities_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
);

CREATE TABLE `spring_security_1`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);

ALTER TABLE `spring_security_1`.`authorities` 
DROP FOREIGN KEY `authorities_ibfk_1`;
ALTER TABLE `spring_security_1`.`authorities` 
ADD CONSTRAINT `authorities_ibfk_1`
  FOREIGN KEY (`student_id`)
  REFERENCES `spring_security_1`.`student` (`student_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

CREATE DATABASE keycloakdb;
CREATE USER 'keycloak_user'@'%' IDENTIFIED BY 'keycloak_password';
GRANT ALL PRIVILEGES ON keycloakdb.* TO 'keycloak_user'@'%';
FLUSH PRIVILEGES;


INSERT INTO `authorities` (`student_id`, `name`)
 VALUES (1, 'VIEWACCOUNT');

INSERT INTO `authorities` (`student_id`, `name`)
 VALUES (1, 'VIEWCARDS');

 INSERT INTO `authorities` (`student_id`, `name`)
  VALUES (1, 'VIEWLOANS');

 INSERT INTO `authorities` (`student_id`, `name`)
   VALUES (1, 'VIEWBALANCE');
   
SELECT `authorities`.`id`,
    `authorities`.`student_id`,
    `authorities`.`name`
FROM `spring_security_1`.`authorities`;

SELECT * FROM student s
 INNER JOIN authorities a ON a.student_id=s.student_id;

SELECT `customer`.`customer_id`,
    `customer`.`name`,
    `customer`.`email`,
    `customer`.`mobile_number`,
    `customer`.`pwd`,
    `customer`.`role`,
    `customer`.`create_dt`
FROM `eazy_bank`.`customer`;

SELECT `student`.`student_id`,
    `student`.`name`,
    `student`.`email`,
    `student`.`mobile_number`,
    `student`.`pwd`,
    `student`.`create_dt`
FROM `spring_security_1`.`student`;

SELECT `roles`.`id`,
    `roles`.`student_id`,
    `roles`.`name`
FROM `spring_security_1`.`roles`;

INSERT INTO `roles` (`student_id`, `name`)
 VALUES (1, 'ROLE_ADMIN');

INSERT INTO `roles` (`student_id`, `name`)
 VALUES (1, 'ROLE_USER');

