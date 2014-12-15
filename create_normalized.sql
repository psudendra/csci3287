DROP DATABASE IF EXISTS store;
CREATE DATABASE store;

USE store;

CREATE TABLE customers
(
	customer_id INT NOT NULL,
	customer_name VARCHAR(50) NOT NULL,
	customer_phone VARCHAR(50) NOT NULL,
	PRIMARY KEY (customer_id)
);
INSERT INTO customers VALUES
(1, 'Priya Sudendra', '222-111-1111'),
(2, 'Sheefali Tewari', '222-222-2222'),
(3, 'Thomas Green', '222-333-3333');

CREATE TABLE address_zipstate
(
	-- state determines zip
	zip VARCHAR(20),
	state VARCHAR(20),
	PRIMARY KEY (zip)
);
INSERT INTO address_zipstate VALUES
('80301', 'CO'),
('80302', 'CO'),
('80303', 'CO');

CREATE TABLE addresses
(
	address_id INT NOT NULL,
	customer_id INT NOT NULL,
	city VARCHAR(20),
	zip VARCHAR(20) REFERENCES address_zipstate(zip),
	PRIMARY KEY (address_id),

	CONSTRAINT address_fk_customers
		FOREIGN KEY (customer_id)
		REFERENCES customers(customer_id),

	CONSTRAINT address_fk_zip
		FOREIGN KEY (zip)
		REFERENCES address_zipstate(zip)
);
INSERT INTO addresses VALUES
(1, 1, 'Boulder', '80301'),
(2, 2, 'Boulder', '80302'),
(3, 3, 'Boulder', '80303');

CREATE TABLE stores
(
	stores_id INT NOT NULL,
	name VARCHAR(20),
	PRIMARY KEY (stores_id)
);
INSERT INTO stores VALUES
(1, 'Boulder'),
(2, 'Park Meadows'),
(3, 'Lafayette'),
(4, 'Broomfield');

CREATE TABLE customers_cards
(
	card_id INT NOT NULL,
	card_number INT(20),
	card_type VARCHAR(20),
	customer_id INT NOT NULL,
	PRIMARY KEY (card_id),

	CONSTRAINT cards_fk_customer
		FOREIGN KEY (customer_id)
		REFERENCES customers(customer_id)
);
INSERT INTO customers_cards VALUES
(1, '111111111', 'AMEX', 1),
(2, '222222222', 'VISA', 3),
(3, '333333333', 'MASTERCARD', 2);

CREATE TABLE suppliers
(
	supplier_id INT NOT NULL,
	supplier_name VARCHAR(20),
	supplier_phone VARCHAR(20),
	PRIMARY KEY (supplier_id)
);
INSERT INTO suppliers VALUES
(1, 'Nike', '234-345-3423'),
(2, '47 Brand', '234-456-1231'),
(3, 'Levi', '343-123-2454');

CREATE TABLE product_type
(
	product_code INT NOT NULL,
	product_description TEXT,
	product_size VARCHAR(10),
	supplier_id INT REFERENCES suppliers(supplier_id),
	PRIMARY KEY (product_code),

	CONSTRAINT type_fk_suppliers
		FOREIGN KEY (supplier_id)
		REFERENCES suppliers(supplier_id)
);
INSERT INTO product_type VALUES
(123, 'Black shirt', 'S', 1),
(456, 'Red hat', NULL, 2),
(789, 'Black jeans', '32', 3);

CREATE TABLE products
(
	product_id INT NOT NULL,
	product_code INT NOT NULL,
	PRIMARY KEY (product_id),

	CONSTRAINT products_fk_type
		FOREIGN KEY (product_code)
		REFERENCES product_type(product_code)
);
INSERT INTO products VALUES
(1, 123),
(2, 456),
(3, 789);

CREATE TABLE employee_addresses
(
	address_id INT NOT NULL,
	street_address VARCHAR(50),
	zipcode VARCHAR(5),
	PRIMARY KEY (address_id)
);
INSERT INTO employee_addresses VALUES
(1, '1111 West Rd.', '80303'),
(2, '2222 Adams Ave.', '24353'),
(3, '3333 Boulder Rd.', '85853');

CREATE TABLE employees
(
	employee_id INT NOT NULL,
	address_id INT NOT NULL,
	employee_name VARCHAR(50),
	employee_phone VARCHAR(50),
	PRIMARY KEY (employee_id),

	CONSTRAINT employees_fk_addresses
		FOREIGN KEY (address_id)
		REFERENCES employee_addresses(address_id)
);
INSERT INTO employees VALUES
(1, 1, 'John Doe', '111-111-1111'),
(2, 2, 'Jane Smith', '111-222-2222'),
(3, 3, 'Lucy Maple', '111-333-3333');

CREATE TABLE customer_purchases 
(
	customer_purchase_id INT NOT NULL,
	customer_id INT NOT NULL,
	employee_id INT NOT NULL,
	card_id INT NOT NULL,
	stores_id INT NOT NULL,
	product_id INT NOT NULL,
	total_purchase_price DECIMAL(4,2) NOT NULL,
	PRIMARY KEY (customer_purchase_ID),

	CONSTRAINT purchase_fk_employee
		FOREIGN KEY (employee_id)
		REFERENCES employees(employee_id),

	CONSTRAINT purchase_fk_customer
		FOREIGN KEY (customer_id)
		REFERENCES customers(customer_id),

	CONSTRAINT purchase_fk_card
		FOREIGN KEY (card_id)
		REFERENCES customers_cards(card_id),

	CONSTRAINT purchase_fk_stores
		FOREIGN KEY (stores_id)
		REFERENCES stores(stores_id),

	CONSTRAINT purchase_fk_product
		FOREIGN KEY (product_id)
		REFERENCES products(product_id)

);
INSERT INTO customer_purchases VALUES
(1, 1, 1, 1, 1, 1, '50.34'),
(2, 2, 2, 2, 2, 3, '20.59'),
(3, 3, 3, 3, 4, 2, '100.68');