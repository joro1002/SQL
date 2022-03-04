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

SELECT p.`peak_name`, r.`river_name`,
LOWER(CONCAT(`peak_name`, SUBSTRING(`river_name`, 2))) AS 'mix'
FROM `peaks` AS p, `rivers` AS r
WHERE RIGHT(`peak_name`, 1) = LEFT(`river_name`, 1)
ORDER BY `mix`;

SELECT `name`, SUBSTRING(`start`, 1, 10) AS 'start'
FROM `games`
WHERE YEAR (`start`) >=2011 AND	 YEAR(`start`)<= 2012
ORDER BY `start`,
`name`
LIMIT 50;

SELECT `user_name`, SUBSTRING(`email`, LOCATE('@', `email`) + 1) AS 'Email Provider' 
FROM `users`
ORDER BY `Email Provider`,
`user_name`;

SELECT `user_name`, `ip_address`
FROM `users`
WHERE `ip_address` LIKE  '___.1%.%.___'
ORDER BY `user_name`;

SELECT `name`,
(CASE
	WHEN HOUR (`start`) BETWEEN 0 AND 11 THEN 'Morning'
    WHEN HOUR (`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN HOUR (`start`) BETWEEN 18 AND 23 THEN 'Evening'
  END  
 ) AS 'Part of the day',
 
 (
 CASE
	WHEN `duration` <= 3 THEN 'Extra Short'
    WHEN `duration` > 3 AND `duration` <= 6 THEN 'Short'
    WHEN `duration` > 6 AND `duration` <= 10 THEN 'Long'
    ELSE 'Extra Long'
 END
 ) AS 'Duration'
 FROM `games`;
 