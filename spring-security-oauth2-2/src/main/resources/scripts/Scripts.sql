create table users(username varchar_ignorecase(50) not null primary key,password varchar_ignorecase(500) not null,enabled boolean not null);
create table authorities (username varchar_ignorecase(50) not null,authority varchar_ignorecase(50) not null,constraint fk_authorities_users foreign key(username) references users(username));
create unique index ix_auth_username on authorities (username,authority);

SELECT `student`.`id`,
    `student`.`student_id`,
    `student`.`email`,
    `student`.`pwd`,
    `student`.`role`
FROM `spring_security_1`.`student`;

INSERT INTO `spring_security_1`.`student`(`student_id`,`email`,`pwd`,`role`)VALUES(1111111111,'student1@email.com','{bcrypt}$2a$12$IfcYJIF5PpE.BcKTUX2Ym.c9E/WLCkY3SfktPW6epyETO62eS.qj6','read');
INSERT INTO `spring_security_1`.`student`(`student_id`,`email`,`pwd`,`role`)VALUES(1111111112,'admin@email.com','{bcrypt}$2a$12$IfcYJIF5PpE.BcKTUX2Ym.c9E/WLCkY3SfktPW6epyETO62eS.qj6','admin');
