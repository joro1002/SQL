CREATE DATABASE `stc`;

CREATE TABLE `addresses`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL
);
CREATE TABLE `categories`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(10) NOT NULL
);
CREATE TABLE `clients`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL
);
CREATE TABLE `drivers`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    age INT NOT NULL,
    rating FLOAT DEFAULT 5.5
);
CREATE TABLE `cars`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(20),
    `year` INT DEFAULT 0 NOT NULL,
    mileage INT DEFAULT 0,
    `condition` CHAR(1) NOT NULL,
    category_id INT NOT NULL,
    CONSTRAINT fk_cars_categories
    FOREIGN KEY (category_id)
    REFERENCES categories(id)
);
CREATE TABLE `courses`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    from_address_id INT NOT NULL,
    CONSTRAINT fk_courses_addresses
    FOREIGN KEY(from_address_id)
    REFERENCES addresses(id),
    `start` DATETIME NOT NULL,
    bill DECIMAL(10, 2) DEFAULT 10,
    car_id INT NOT NULL,
    CONSTRAINT fk_courses_cars
    FOREIGN KEY(car_id)
    REFERENCES cars(id),
    client_id INT NOT NULL,
    CONSTRAINT fk_courses_clients
    FOREIGN KEY (client_id)
    REFERENCES clients(id)
);
CREATE TABLE `cars_drivers`(
	car_id INT NOT NULL,
    driver_id INT NOT NULL,
    CONSTRAINT pk_cars_drivers
    PRIMARY KEY (car_id, driver_id),
    CONSTRAINT fk_cars_drivers_cars
    FOREIGN KEY (car_id)
    REFERENCES cars(id),
    CONSTRAINT fk_cars_drivers_drivers
    FOREIGN KEY (driver_id)
    REFERENCES drivers(id)
);


INSERT INTO `clients`(full_name, phone_number)
SELECT CONCAT(`first_name`, ' ', `last_name`) AS 'full_name',
	CONCAT('(088) 9999', `id` * 2) AS 'phone_number'
    FROM drivers
    WHERE id BETWEEN 10 AND 20;
    
UPDATE cars
SET `condition` = 'C'
WHERE (mileage >= 800000  OR mileage IS NULL) AND `year` <= 2010 AND make != 'Mercedes-Benz';

DELETE cl.* FROM `clients`AS cl
LEFT JOIN courses AS c
ON c.client_id = cl.id
WHERE c.id IS NULL AND CHAR_LENGTH(full_name) > 3;


SELECT `make`, `model`, `condition`
FROM `cars`
ORDER BY id;


SELECT d.`first_name`, d.`last_name`, c.`make`, c.`model`, c.`mileage`
FROM drivers AS d
JOIN cars_drivers AS cd
ON d.id = cd.driver_id
JOIN cars AS c
ON cd.car_id = c.id
WHERE c.mileage IS NOT NULL
ORDER BY c.mileage DESC,
d.first_name;


SELECT c.`id`, c.`make`, c.`mileage`, COUNT(co.id) AS 'count_of_courses', ROUND(AVG(co.bill),2) AS 'avg_bill'
FROM `cars` AS c
LEFT JOIN `courses` AS co
ON c.id = co.car_id
GROUP BY c.id  
HAVING count_of_courses != 2
ORDER BY count_of_courses DESC,
c.id;

SELECT c.`full_name`, COUNT(co.car_id), SUM(co.bill) 
FROM `clients` AS c
JOIN `courses` AS co
ON c.id = co.client_id
GROUP BY c.id
HAVING SUBSTRING(c.full_name, 2, 1) = 'a' AND COUNT(co.car_id) > 1
ORDER BY full_name;


SELECT a.`name`, IF(HOUR(c.`start`) BETWEEN 6 AND 20, 'Day', 'Night') AS 'day_time',
c.bill, cl.full_name, ca.make, ca.model, cat.`name`
FROM `addresses` AS a
JOIN `courses` AS c
ON a.id = c.from_address_id
JOIN `clients` AS cl
ON cl.id = c.client_id
JOIN `cars` AS ca
ON ca.id = c.car_id
JOIN `categories` AS cat
ON cat.id = ca.category_id
ORDER BY c.id;


DELIMITER $$
CREATE FUNCTION udf_courses_by_client (phone_num VARCHAR (20)) 
RETURNS INT
DETERMINISTIC
BEGIN 
	RETURN (
		SELECT COUNT(c.id)
	FROM `clients` AS cl
	LEFT JOIN `courses` AS c
	ON cl.id = c.client_id
	GROUP BY cl.phone_number
	HAVING cl.phone_number = phone_num
    );
END $$
DELIMITER ;
SELECT udf_courses_by_client ('(803) 6386812') as `count`; 
SELECT udf_courses_by_client ('(831) 1391236') as `count`;
SELECT udf_courses_by_client ('(704) 2502909') as `count`;




DELIMITER $$
CREATE PROCEDURE udp_courses_by_address (address_name VARCHAR(100))
BEGIN
	SELECT a.`name`, cl.full_name, 
(
CASE
	WHEN c.bill <= 20 THEN 'Low'
    WHEN c.bill BETWEEN 21 AND 30 THEN 'Medium'
    ELSE 'High'
END
) AS 'level_of_bill', ca.make, ca.`condition`, cat.`name`
	FROM `addresses` AS a
	JOIN `courses` AS c
	ON a.id = c.from_address_id
	JOIN clients AS cl
	ON cl.id = c.client_id
	JOIN cars AS ca
	ON ca.id = c.car_id
	JOIN categories AS cat
	ON cat.id = ca.category_id
	WHERE a.`name` = address_name
	ORDER BY ca.make,
	cl.full_name;
END $$
DELIMITER ;

CALL udp_courses_by_address('66 Thompson Drive');