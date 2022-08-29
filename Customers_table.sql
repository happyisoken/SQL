CREATE TABLE customers
(
	customer_id INT,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	email_address VARCHAR(255) NOT NULL,
	number_of_complaints INT
);

USE Sales;

SELECT * FROM customers;

SELECT * FROM sales.customers;

/*do not execute*/

USE sales;

DROP TABLE customers;

CREATE TABLE customers
(
customer_id int,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
number_of_complaints int,
primary key (customer_id)
);

DROP TABLE Customers;

CREATE TABLE customers
(
	customer_id int,
	first_name varchar(255),
	last_name varchar(255),
	email_address varchar(255),
	number_of_complaints int,
primary key (customer_id),
UNIQUE KEY (email_address)
);

DROP TABLE Customers;

CREATE TABLE Customers
(
	customer_id int,
	first_name varchar(255),
	last_name varchar(255),
	email_address varchar(255),
	number_of_complaints int,
primary key (customer_id)
);

ALTER TABLE customers
ADD UNIQUE KEY (email_address);

ALTER TABLE customers
DROP INDEX email_address;

DROP TABLE Customers;

CREATE TABLE Customers
(
	customer_id int auto_increment,
	first_name varchar(255),
	last_name varchar(255),
	email_address varchar(255),
	number_of_complaints int,
primary key (customer_id)
);

ALTER TABLE customers
ADD COLUMN gender ENUM ('M', 'F') AFTER last_name;

ALTER TABLE Customers
CHANGE COLUMN number_of_complaints number_of_complaint int DEFAULT 0;

INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)

VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365datascience.com', 0)
;
SELECT * from customers;