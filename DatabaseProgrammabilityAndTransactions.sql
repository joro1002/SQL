DELIMITER $$
CREATE PROCEDURE `usp_get_employees_salary_above_35000` ()
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE `salary` > 35000
    ORDER BY `first_name`,
    `last_name`,
    `employee_id`;
	END $$
DELIMITER ;
CALL usp_get_employees_salary_above_35000();

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above (salary DECIMAL(20, 4))
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees` AS e
    WHERE e.`salary` >= salary
    ORDER BY first_name,
    last_name,
    employee_id;
END $$
DELIMITER ;
CALL usp_get_employees_salary_above(45000);

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (startLetter VARCHAR(40))
BEGIN 
	SELECT `name`
    FROM `towns`
    WHERE `name` LIKE CONCAT(startLetter, '%')
    ORDER BY `name`;
END $$
DELIMITER ;
CALL usp_get_towns_starting_with('b')


DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town (town_name VARCHAR(50))
BEGIN
	SELECT e.`first_name`, e.`last_name`
    FROM `employees` AS e
    JOIN `addresses` AS a
    ON e.address_id = a.address_id
    JOIN `towns` AS t
    ON t.town_id = a.town_id
    WHERE t.`name` = town_name
    ORDER BY e.first_name,
    e.last_name,
    e.employee_id;
END $$
DELIMITER ;
CALL usp_get_employees_from_town('Sofia');


    