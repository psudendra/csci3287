# 1 - Simple SELECT FROM WHERE statement
SELECT * FROM `addresses` WHERE `zip`='80303';

# 2 - SELECT FROM WHERE ORDER BY
SELECT * FROM `employees` WHERE `employee_id` < 3 ORDER BY `employee_name`;

# 3 - SELECT FROM WHERE ORDER BY LIMIT
SELECT * FROM `employees` WHERE `employee_id` < 3 ORDER BY `employee_name` LIMIT 1;

# 4 - SELECT FROM WHERE with implicit JOIN
SELECT 
	addresses.city,
	addresses.zip,
	address_zipstate.state
FROM 
	`addresses`, `address_zipstate` 
WHERE 
	addresses.zip = address_zipstate.zip;

# 5 - SELECT FROM WHERE GROUP BY
# Groups the orders by customer_id
SELECT 
	COUNT(customer_purchases.customer_id) AS NumberOFOrders,
	customers.customer_id,
	customers.customer_name
FROM 
	`customer_purchases`, `customers`
WHERE 
	customer_purchases.customer_id = customers.customer_id
GROUP BY 
	customers.customer_id;

# 6 - SELECT FROM WHERE GROUP BY HAVING
# gives customers that have ordered more than 2 times
SELECT 
	COUNT(customer_purchases.customer_purchase_id) AS NumberOFOrders,
	customers.customer_id,
	customers.customer_name
FROM 
	`customer_purchases`, `customers`
WHERE 
	customer_purchases.customer_purchase_id = customers.customer_id
GROUP BY 
	customers.customer_id
HAVING COUNT(customer_purchases.customer_purchase_id) > 2;


# 7 - SELECT FROM WHERE with two implied JOINS, a MAX function, AVG function
# gives 
SELECT MAX(AVG), CustName
FROM (SELECT AVG(customer_purchases.total_purchase_price) AS AVG, customers.customer_name AS CustName
	FROM `customer_purchases`, `customers`, `addresses`
	WHERE (customer_purchases.customer_id = customers.customer_id) AND (customers.customer_id = addresses.customer_id)
	GROUP BY customers.customer_id) AS A;


# 8 - SELECT FROM WHERE NOT and IN
# Gives customers that pay with VISA.
SELECT customer_id
FROM `customers_cards`
WHERE customer_id NOT IN (
	SELECT customer_id
	FROM `customers_cards`
	WHERE card_type = 'VISA'
);

# 9 - SET COMMAND and WHERE (nontrivial) 10 - UPDATE with WHERE (nontrivial)
UPDATE customer_purchases
SET total_purchase_price='94.23'
WHERE total_purchase_price > '100.00';

# 11 - CREATE USER
CREATE USER psudendra@localhost IDENTIFIED BY 'password';
GRANT ALL ON store.* TO psudendra@localhost;

# 12 - DROP USER
DROP USER psudendra@localhost;

# 13 - START TRANSACTION and a ROLLBACK
START TRANSACTION;
DELETE FROM customer_purchases WHERE total_purchase_price < '30.00';
ROLLBACK;