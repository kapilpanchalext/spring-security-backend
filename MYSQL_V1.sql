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
