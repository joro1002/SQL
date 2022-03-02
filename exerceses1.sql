CREATE DATABASE `minions`;

CREATE TABLE `minions`(
`id` int PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45),
`age`int
);

CREATE TABLE `towns`(
`town` int PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45)
);

ALTER TABLE `minions`
ADD COLUMN `town_id` INT,
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY (`town_id`)
REFERENCES `towns`(`id`);


INSERT INTO `minions`(`id`, `name`, `age`, `town_id`)
VALUES
(1, 'Kevin', 22, 2),
(2, 'Bob', 15, 5),
(3, 'Bibi', 12, 4);
 
INSERT INTO `towns`(`id`, `name`)
VALUES
(6, 'Sofia'),
(7, 'Sandaski'),
(8, 'Varna');

TRUNCATE `minions`;

DROP TABLE `minions`;

CREATE TABLE `people`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(200) NOT NULL,
`picture` BLOB,
`height` DOUBLE(3,2),
`weight` DOUBLE(5, 2),
`gender` CHAR(1) NOT NULL,
`birthdate` DATE NOT NULL,
`biography` TEXT);

INSERT INTO `people` (id,`name`, picture, height, weight, gender, birthdate, biography)
VALUES(1, 'Gosho', NULL, 0.67, 12, 'm', '2019-11-06', 'az'),
(2, 'Ivan', NULL, 0.14, 16, 'f', '2020-11-01', 'iiiiiaa'),
(3, 'Pesho', NULL, 0.26, 22, 'f', '2027-11-01', 'iia'),
(4, 'Geri', NULL, 0.9, 11, 'f', '2020-02-01', 'iiiiiaa'),
(5, 'Ded', NULL, 0.11, 12, 'm', '2020-01-22', 'iiiiiaa');


CREATE DATABASE `Movies`;

CREATE TABLE `directors`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`director_name` VARCHAR(40) NOT NULL,
`notes` TEXT);

INSERT INTO `directors`(`id`, `director_name`, `notes`)
VALUES('1','Gosho',NULL), 
('2','Ivan',NULL), 
('3','Geri',NULL), 
('4','Mitko',NULL), 
('5','Djeri',NULL);

CREATE TABLE `genres`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`genre_name` VARCHAR(50) NOT NULL,
`notes` TEXT);

INSERT INTO `genres`(`id`, `genre_name`, `notes`)
VALUES(1, 'Drama', NULL),
(2, 'Comedy', NULL),
(3, 'Action', NULL),
(4, 'Animation', NULL),
(5, 'Parody', NULL);

CREATE TABLE `categories`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`category_name` VARCHAR(50) NOT NULL,
`notes` TEXT);

INSERT INTO `categories`(`id`, `category_name`, `notes`)
VALUES(1, 'qqqqq', NULL),
(2, 'eeeee', NULL),
(3, 'rrr', NULL),
(4, 'tttt', NULL),
(5, 'ddd', NULL);
  
  CREATE TABLE `movies` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NOT NULL,
  `director_id` INT,
  `copyright_year` YEAR,
  `LENGTH` TIME,
  `genre_id` INT,
   `category_id` INT,
   `rating` DECIMAL(2,1),
   `notes` TEXT);
   
   INSERT INTO `movies`(`id`, `title`, `director_id`, `copyright_year`,`LENGTH`, `genre_id`,`category_id`, `rating`, `notes`)
   VALUES(1, 'zzzz', '2', '2000', '00:01:00', '1', '1', NULL, NULL),
   (2, 'vvvvvvv', '3', '2001', '00:02:00', '2', '2', NULL, NULL),
   (3, 'nnnnnnn', '4', '2003', '00:03:00', '3', '3', NULL, NULL),
   (4, 'mmmm', '5', '2004', '00:04:00', '4', '4', NULL, NULL),
   (5, 'fff', '6', '2005', '00:05:00', '5', '5', NULL, NULL);
   
   
   
   
   CREATE DATABASE `soft_uni`;
   
   CREATE TABLE `towns`(
   `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   `name` VARCHAR(40) NOT NULL);
   
   CREATE TABLE `addresses`(
   `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   `address_text` VARCHAR(40) NOT NULL,
   `town_id` INT,
   CONSTRAINT fk_addresses_towns
   FOREIGN KEY (`town_id`)
   REFERENCES `towns`(`id`)
   );
   
   CREATE TABLE `departments` (
      `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
      `name` VARCHAR(40) NOT NULL
   );
   
   CREATE TABLE `employees` (
   `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   `first_name` VARCHAR(40) NOT NULL,
   `middle_name` VARCHAR(40) NOT NULL,
   `last_name` VARCHAR(40) NOT NULL,
   `job_title` VARCHAR(40) NOT NULL,
   `department_id` INT NOT NULL,
   `hire_date` DATE,
   `salary` DECIMAL(20, 2),
   `address_id` INT,
   CONSTRAINT fk_employees_departments
   FOREIGN KEY (`department_id`)
   REFERENCES `departments`(`id`),
   CONSTRAINT fk_employees_addresses
   FOREIGN KEY (`address_id`)
   REFERENCES `addresses`(`id`)
   );
   
   
   INSERT INTO `towns`
   VALUES('1', 'Sofia'),
   ('2', 'Plovdiv'),
   ('3', 'Varna'),
   ('4', 'Burgas');
   
   INSERT INTO `departments`
   VALUES('1', 'Engineering'),
   ('2', 'Sales'),
   ('3', 'Marketing'),
   ('4', 'Software Development'),
   ('5', 'Quality Assurance');
   
   INSERT INTO `employees` (`id`, `first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`, 
   `salary`)
   VALUES('1', 'Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
   ('2', 'Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
   ('3', 'Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
   ('4', 'Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
   ('5', 'Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);


SELECT * FROM `towns`
ORDER BY `name`;
SELECT * FROM `departments`
ORDER BY `name`;
SELECT * FROM `employees`
ORDER BY `salary` DESC;



