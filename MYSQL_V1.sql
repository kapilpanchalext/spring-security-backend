SELECT `student`.`created_date`,
    `student`.`last_modified_date`,
    `student`.`student_id`,
    `student`.`id`,
    `student`.`created_by`,
    `student`.`email`,
    `student`.`last_modified_by`,
    `student`.`mobile_number`,
    `student`.`name`,
    `student`.`password`
FROM `student_database`.`student`;

SELECT `roles`.`id`,
    `roles`.`student_id`,
    `roles`.`name`
FROM `student_database`.`roles`;

INSERT INTO `student_database`.`roles`(`id`,`student_id`,`name`)VALUES('8faeb3de-44b4-4560-ac62-0b2fb1246855',9999999999,"ADMIN");

INSERT INTO `student_database`.`roles`(`id`,`student_id`,`name`)VALUES('b6611e15-3a94-41f7-8b20-a295f11edf50',1111111112,"BASIC");

