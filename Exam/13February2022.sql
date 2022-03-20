CREATE DATABASE `online_store`;

CREATE TABLE `brands`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL UNIQUE
);
CREATE TABLE `categories`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL UNIQUE
);
CREATE TABLE `reviews`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    content TEXT,
    rating DECIMAL(10,2) NOT NULL,
    picture_url VARCHAR(80) NOT NULL,
    published_at DATETIME NOT NULL
);
CREATE TABLE `products`(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(40) NOT NULL,
    price DECIMAL(19,2) NOT NULL,
    quantity_in_stock INT,
    `description` TEXT,
    brand_id INT NOT NULL,
    CONSTRAINT fk_products_brands
    FOREIGN KEY (brand_id)
    REFERENCES  brands(id),
    category_id INT NOT NULL,
    CONSTRAINT fk_porducts_categories
    FOREIGN KEY (category_id)
    REFERENCES categories(id),
    review_id INT,
    CONSTRAINT fk_products_reviews
    FOREIGN KEY (review_id)
    REFERENCES reviews(id)
);
CREATE TABLE `customers`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    phone VARCHAR(30) NOT NULL UNIQUE,
    address VARCHAR(60) NOT NULL,
    discount_card BIT(1) NOT NULL 
);
CREATE TABLE `orders`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_datetime DATETIME NOT NULL,
    customer_id INT NOT NULL,
    CONSTRAINT fk_orders_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers(id)
);
CREATE TABLE `orders_products`(
	order_id INT,
    CONSTRAINT fk_orders_products_orders
    FOREIGN KEY (order_id)
    REFERENCES orders(id),
    product_id INT,
    CONSTRAINT fk_orders_products_products
    FOREIGN KEY (product_id)
    REFERENCES products(id)
);

INSERT INTO `reviews`(content, picture_url, published_at, rating)
SELECT LEFT(`description`, 15), reverse(`name`), '2010-10-10', price / 8
FROM products
WHERE id >=5;

UPDATE `products`
SET quantity_in_stock = quantity_in_stock - 5
WHERE quantity_in_stock BETWEEN 60 AND 70;

DELETE FROM `customers` AS c
LEFT JOIN `orders` AS o
ON c.id = o.customer_id
WHERE o.id IS NULL


SELECT id, `name`
FROM `categories`
ORDER BY `name` DESC;

SELECT `id`, `brand_id`, `name`, `quantity_in_stock`
FROM `products`
WHERE price > 1000 AND quantity_in_stock < 30
ORDER BY quantity_in_stock,
id;

SELECT `id`, `content`, `rating`, `picture_url`, `published_at`
FROM `reviews`
WHERE content LIKE 'My%' AND LENGTH(content) > 61
ORDER BY rating DESC;

SELECT CONCAT(`first_name`, ' ', `last_name`) AS 'full_name', c.`address`, o.`order_datetime`
FROM `customers` AS c
JOIN `orders` AS o
ON c.id = o.customer_id
WHERE YEAR(order_datetime) <= 2018
ORDER BY full_name DESC;


SELECT COUNT(*) AS 'items_count', c.`name`, SUM(quantity_in_stock) AS 'total_quantity'
FROM products AS p
JOIN categories AS c
ON p.category_id = c.id
GROUP BY p.category_id
ORDER BY items_count DESC,
total_quantity
LIMIT 5;


DELIMITER $$
CREATE FUNCTION udf_customer_products_count(name_param VARCHAR(30))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN (SELECT  COUNT(*) 
    FROM `customers` AS c
    JOIN `orders` AS o
    ON c.id = o.customer_id
    JOIN `orders_products` AS ap
    ON o.id = ap.order_id
	WHERE c.first_name = name_param
    GROUP BY c.id);
END$$
DELIMITER ;
SELECT udf_customer_products_count('Shirley');

SELECT c.first_name,c.last_name, udf_customer_products_count('Shirley') as `total_products` FROM customers c
WHERE c.first_name = 'Shirley';
