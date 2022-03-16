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
