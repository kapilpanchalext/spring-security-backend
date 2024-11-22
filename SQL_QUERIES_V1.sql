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

SELECT `user_entity`.`ID`,
    `user_entity`.`EMAIL`,
    `user_entity`.`EMAIL_CONSTRAINT`,
    `user_entity`.`EMAIL_VERIFIED`,
    `user_entity`.`ENABLED`,
    `user_entity`.`FEDERATION_LINK`,
    `user_entity`.`FIRST_NAME`,
    `user_entity`.`LAST_NAME`,
    `user_entity`.`REALM_ID`,
    `user_entity`.`USERNAME`,
    `user_entity`.`CREATED_TIMESTAMP`,
    `user_entity`.`SERVICE_ACCOUNT_CLIENT_LINK`,
    `user_entity`.`NOT_BEFORE`
FROM `keycloak`.`user_entity`;

SELECT `realm`.`ID`,
    `realm`.`ACCESS_CODE_LIFESPAN`,
    `realm`.`USER_ACTION_LIFESPAN`,
    `realm`.`ACCESS_TOKEN_LIFESPAN`,
    `realm`.`ACCOUNT_THEME`,
    `realm`.`ADMIN_THEME`,
    `realm`.`EMAIL_THEME`,
    `realm`.`ENABLED`,
    `realm`.`EVENTS_ENABLED`,
    `realm`.`EVENTS_EXPIRATION`,
    `realm`.`LOGIN_THEME`,
    `realm`.`NAME`,
    `realm`.`NOT_BEFORE`,
    `realm`.`PASSWORD_POLICY`,
    `realm`.`REGISTRATION_ALLOWED`,
    `realm`.`REMEMBER_ME`,
    `realm`.`RESET_PASSWORD_ALLOWED`,
    `realm`.`SOCIAL`,
    `realm`.`SSL_REQUIRED`,
    `realm`.`SSO_IDLE_TIMEOUT`,
    `realm`.`SSO_MAX_LIFESPAN`,
    `realm`.`UPDATE_PROFILE_ON_SOC_LOGIN`,
    `realm`.`VERIFY_EMAIL`,
    `realm`.`MASTER_ADMIN_CLIENT`,
    `realm`.`LOGIN_LIFESPAN`,
    `realm`.`INTERNATIONALIZATION_ENABLED`,
    `realm`.`DEFAULT_LOCALE`,
    `realm`.`REG_EMAIL_AS_USERNAME`,
    `realm`.`ADMIN_EVENTS_ENABLED`,
    `realm`.`ADMIN_EVENTS_DETAILS_ENABLED`,
    `realm`.`EDIT_USERNAME_ALLOWED`,
    `realm`.`OTP_POLICY_COUNTER`,
    `realm`.`OTP_POLICY_WINDOW`,
    `realm`.`OTP_POLICY_PERIOD`,
    `realm`.`OTP_POLICY_DIGITS`,
    `realm`.`OTP_POLICY_ALG`,
    `realm`.`OTP_POLICY_TYPE`,
    `realm`.`BROWSER_FLOW`,
    `realm`.`REGISTRATION_FLOW`,
    `realm`.`DIRECT_GRANT_FLOW`,
    `realm`.`RESET_CREDENTIALS_FLOW`,
    `realm`.`CLIENT_AUTH_FLOW`,
    `realm`.`OFFLINE_SESSION_IDLE_TIMEOUT`,
    `realm`.`REVOKE_REFRESH_TOKEN`,
    `realm`.`ACCESS_TOKEN_LIFE_IMPLICIT`,
    `realm`.`LOGIN_WITH_EMAIL_ALLOWED`,
    `realm`.`DUPLICATE_EMAILS_ALLOWED`,
    `realm`.`DOCKER_AUTH_FLOW`,
    `realm`.`REFRESH_TOKEN_MAX_REUSE`,
    `realm`.`ALLOW_USER_MANAGED_ACCESS`,
    `realm`.`SSO_MAX_LIFESPAN_REMEMBER_ME`,
    `realm`.`SSO_IDLE_TIMEOUT_REMEMBER_ME`,
    `realm`.`DEFAULT_ROLE`
FROM `keycloak`.`realm`;

SELECT `user_role_mapping`.`ROLE_ID`,
    `user_role_mapping`.`USER_ID`
FROM `keycloak`.`user_role_mapping`;

SELECT `client`.`ID`,
    `client`.`ENABLED`,
    `client`.`FULL_SCOPE_ALLOWED`,
    `client`.`CLIENT_ID`,
    `client`.`NOT_BEFORE`,
    `client`.`PUBLIC_CLIENT`,
    `client`.`SECRET`,
    `client`.`BASE_URL`,
    `client`.`BEARER_ONLY`,
    `client`.`MANAGEMENT_URL`,
    `client`.`SURROGATE_AUTH_REQUIRED`,
    `client`.`REALM_ID`,
    `client`.`PROTOCOL`,
    `client`.`NODE_REREG_TIMEOUT`,
    `client`.`FRONTCHANNEL_LOGOUT`,
    `client`.`CONSENT_REQUIRED`,
    `client`.`NAME`,
    `client`.`SERVICE_ACCOUNTS_ENABLED`,
    `client`.`CLIENT_AUTHENTICATOR_TYPE`,
    `client`.`ROOT_URL`,
    `client`.`DESCRIPTION`,
    `client`.`REGISTRATION_TOKEN`,
    `client`.`STANDARD_FLOW_ENABLED`,
    `client`.`IMPLICIT_FLOW_ENABLED`,
    `client`.`DIRECT_ACCESS_GRANTS_ENABLED`,
    `client`.`ALWAYS_DISPLAY_IN_CONSOLE`
FROM `keycloak`.`client`;




