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


DELIMITER $$
CREATE FUNCTION ufn_get_salary_level (e_salary DECIMAL(20, 2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	RETURN(
		CASE
			WHEN e_salary < 30000 THEN 'Low'
            WHEN e_salary  BETWEEN 30000 AND 50000 THEN 'Average'
            WHEN e_salary > 50000 THEN 'High'
        END
    );
END $$
DELIMITER ;

SELECT ufn_get_salary_level(13500.00);

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level (level_salary VARCHAR(10))
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE ufn_get_salary_level(salary) = level_salary
    ORDER BY first_name DESC,
    last_name DESC;
END $$
DELIMITER ;

CALL usp_get_employees_by_salary_level('High');



DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN (SELECT word REGEXP set_of_letters);
END $$
DELIMITER ;
SELECT ufn_is_word_comprised('oistmiahf', 'Sofia');

    
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name ()  
BEGIN
	SELECT CONCAT(`first_name`, ' ', `last_name`) AS 'full_name'
    FROM `account_holders`
    ORDER BY full_name,
    id;
END $$
DELIMITER ;
CALL usp_get_holders_full_name();


DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(numberParam INT)
BEGIN
	SELECT ah.`first_name`, ah.`last_name`
    FROM `account_holders` AS ah
    JOIN `accounts` AS a
    ON ah.id = a.account_holder_id
    GROUP BY ah.id, ah.first_name, ah.last_name
    HAVING SUM(balance) > numberParam
    ORDER BY ah.id;
    
END $$
DELIMITER ;
CALL usp_get_holders_with_balance_higher_than(7000);


DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value (sum DECIMAL(20, 4), interest DOUBLE, years INT)
RETURNS DECIMAL(20, 4)
DETERMINISTIC
BEGIN
	RETURN sum * POW(1+ interest, years);
END $$
DELIMITER ;
SELECT ufn_calculate_future_value(1000, 0.5, 5);


DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(acc_id INT, interest DOUBLE)
BEGIN 
	SELECT a.`id` AS 'account_id', ah.`first_name`, ah.`last_name`, a.`balance` AS 'current_balance',
    ufn_calculate_future_value(a.balance, interest, 5) AS 'balance_in_5_years'
    FROM `accounts` AS a
    JOIN `account_holders` AS ah
    ON a.account_holder_id = ah.id
    WHERE a.id = acc_id;
END $$
DELIMITER ;
CALL usp_calculate_future_value_for_account(1, 0.1);


DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(20, 4))
BEGIN 	
	START TRANSACTION;
	IF(SELECT COUNT(*) FROM `accounts` WHERE id = account_id) = 0
		OR(money_amount <= 0)
		THEN ROLLBACK;
    
    ELSE 
    UPDATE accounts
    SET balance = balance +  money_amount
    WHERE id = account_id;
    END IF;
END $$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(20, 4))
BEGIN 	
	START TRANSACTION;
	IF(SELECT COUNT(*) FROM `accounts` WHERE id = account_id) = 0
		OR(money_amount <= 0)
        OR (SELECT balance FROM accounts WHERE id = account_id) < money_amount
		THEN ROLLBACK;
    
    ELSE 
		UPDATE accounts
		SET balance = balance - money_amount
		WHERE id = account_id;
	END IF;
END $$
DELIMITER ;
CALL usp_withdraw_money(1, 10);



DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, money_amount DECIMAL(20, 4))
BEGIN 	
	START TRANSACTION;
	IF(SELECT COUNT(*) FROM `accounts` WHERE id = from_account_id) = 0
		OR (SELECT COUNT(*) FROM `accounts` WHERE id = to_account_id) = 0
		OR(money_amount <= 0)
        OR (SELECT balance FROM accounts WHERE id = from_account_id) < money_amount
        OR from_account_id <= 0
        OR to_account_id <= 0
		THEN ROLLBACK;
    
    ELSE 
		UPDATE accounts
		SET balance = balance - money_amount
		WHERE id = from_account_id;
        
        UPDATE accounts
		SET balance = balance + money_amount
		WHERE id = to_account_id;
	END IF;
END $$
DELIMITER ;
CALL usp_transfer_money(1,2,10);