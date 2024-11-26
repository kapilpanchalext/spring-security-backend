SELECT *
FROM `student_database`.`roles`;

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

SELECT `student_roles`.`student_id`,
    `student_roles`.`id`
FROM `student_database`.`student_roles`;
