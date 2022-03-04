SELECT `first_name`, `last_name` FROM `employees`
WHERE SUBSTRING(`first_name`, 1, 2) = 'Sa';

SELECT `first_name`, `last_name` FROM `employees`
WHERE `last_name` LIKE'%ei%';

SELECT `first_name` FROM `employees`
WHERE `department_id` IN (3, 10)
AND YEAR (`hire_date`) BETWEEN 1995 AND 2005;

SELECT `first_name`, `last_name` FROM `employees`
WHERE `job_title` NOT LIKE '%engineer%';

SELECT `name` FROM `towns`
WHERE char_length(`name`) IN (5,6)
ORDER BY `name`;

SELECT `town_id`, `name` FROM `towns`
WHERE `name` LIKE 'M%'
OR `name` LIKE 'K%'
OR `name` LIKE 'B%'
OR `name` LIKE 'E%'
ORDER BY `name`;

SELECT `town_id`, `name` FROM `towns`
WHERE `name` NOT LIKE 'R%'
AND `name` NOT LIKE 'B%'
AND `name` NOT LIKE 'D%'
ORDER BY `name`;

CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`, `last_name` 
FROM `employees`
WHERE YEAR (`hire_date`) > 2000;

SELECT `first_name`, `last_name` FROM `employees`
WHERE CHAR_LENGTH(`last_name`) = 5;

SELECT `country_name`, `iso_code` FROM `countries`
WHERE `country_name` LIKE '%A%A%A%'
ORDER BY `iso_code`;