DROP DATABASE IF EXISTS store;
CREATE DATABASE store;

USE store;

CREATE TABLE customers
(
	customer_id INT NOT NULL,
	address_id INT NOT NULL,
	customer_name VARCHAR(50) NOT NULL,
	customer_phone VARCHAR(50) NOT NULL,
	customer_card_id VARCHAR(50),
	customer_card_type VARCHAR(20),
	stores_id INT NOT NULL,
	product_id INT NOT NULL,
	total_purchase_price DECIMAL(4,2) NOT NULL,
	PRIMARY KEY (customer_id)
);
INSERT INTO customers VALUES
(1, 'Priya Sudendra', '222-111-1111', '111111111', 'AMEX', 'Boulder', 1, '50.34'),
(2, 'Sheefali Tewari', '222-222-2222', '222222222', 'VISA', 'Park Meadows', 3, '20.59'),
(3, 'Thomas Green', '222-333-3333','333333333', 'MASTERCARD', 'Lafayette', 2, '100.68');

CREATE TABLE addresses
(
	address_id INT NOT NULL,
	customer_id INT NOT NULL,
	city VARCHAR(20),
	zip VARCHAR(20),
	state VARCHAR(20),
	PRIMARY KEY (address_id),

	CONSTRAINT address_fk_customers
		FOREIGN KEY (customer_id)
		REFERENCES customers(customer_id),
);
INSERT INTO addresses VALUES
(1, 1, 'Boulder', '80301', 'CO'),
(2, 2, 'Boulder', '80302', 'CO'),
(3, 3, 'Boulder', '80303', 'CO');

CREATE TABLE products
(
	product_id INT NOT NULL,
	product_description TEXT,
	product_size VARCHAR(10),
	supplier_name VARCHAR(20),
	supplier_phone VARCHAR(20),
	PRIMARY KEY (product_id),
);
INSERT INTO products VALUES
(1, 123, 'Black shirt', 'S', 1, 'Nike', '234-345-3423'),
(2, 456, 'Red hat', NULL, 2, '47 Brand', '234-456-1231'),
(3, 789, 'Black jeans', '2', 3, 'Levi', '343-123-2454');

CREATE TABLE employees
(
	employee_id INT NOT NULL,
	address_id INT NOT NULL,
	employee_name VARCHAR(50),
	employee_phone VARCHAR(50),
	street_address VARCHAR(50),
	zipcode VARCHAR(5),
	PRIMARY KEY (employee_id),

	CONSTRAINT employees_fk_addresses
		FOREIGN KEY (address_id)
		REFERENCES employee_addresses(address_id)
);
INSERT INTO employees VALUES
(1, 1, 'John Doe', '111-111-1111', '1111 West Rd.', '80303'),
(2, 2, 'Jane Smith', '111-222-2222', '2222 Adams Ave.', '24353'),
(3, 3, 'Lucy Maple', '111-333-3333', '3333 Boulder Rd.', '85853');