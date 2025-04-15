-- step 1 create a database for our sales data
create database	Sales_data;

-- step 2 use this datbase from our SQL workbench
use sales_data;

-- step 3 create tables to store the data 
-- we must have to first design the database schema to define that how we store the data 

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    registration_date DATE
);

-- step 4 create table for products 
create table products(
			product_id INT PRIMARY KEY,
            product_name VARCHAR(100),
            category VARCHAR(100),
            price DECIMAL(10,2)
);
            
-- step 5 create table for orders that is the main table in our business
create table orders(
			order_id INT PRIMARY KEY,
            customer_id INT,
            product_id INT,
            quantity INT,
            order_date DATE,
            FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
            FOREIGN KEY (product_id) REFERENCES products(product_id)
	);
     
    
-- step 6 insert the data into customer tables

insert into customers values
(1,"Sumit","sumitghanghas291@gmail.com","Bhiwani","2022-01-15"),
(2,"Amit","amitkumar291@gmail.com","Rohtak","2020-03-22"),
(3,"Ankit","ankitkumar290@gmail.com","Jind","2021-05-10");

-- step 7 insert the data into the product table

insert into products values
(101,"Laptop","electronis",999.99),
(102, 'Smartphone', 'Electronics', 699.99),
(103, 'Desk Chair', 'Furniture', 149.99);


-- step 8 insert into the orders table

insert into orders values
(1001, 1, 101, 1, '2023-01-10'),
(1002, 2, 102, 2, '2023-02-15'),
(1003, 3, 103, 1, '2023-03-20');


--   SQL Queries for Analysis (Key for Interviews)
-- Question_1. Total Sales Revenue

SELECT SUM(p.price * o.quantity) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id;


-- Question 2 Top-Selling Products

SELECT p.product_name, SUM(o.quantity) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Question 3 Customer Purchase History
SELECT c.customer_name, p.product_name, o.quantity, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

-- Question 4 Monthly Sales Trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(p.price * o.quantity) AS monthly_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- Question 5 Customers Who Never Purchased
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;