-- ============================================
-- COMPLETE SQL EXAMPLE - BEGINNING TO END
-- ============================================
-- This file demonstrates a complete SQL workflow:
-- 1. Create database/schema
-- 2. Create tables
-- 3. Insert data
-- 4. Query data
-- 5. Verify results
-- ============================================

-- STEP 1: Create the database/schema
-- ============================================
CREATE SCHEMA IF NOT EXISTS ORGANIZATION;
USE ORGANIZATION;

-- STEP 2: Create tables
-- ============================================
-- Customer table
CREATE TABLE IF NOT EXISTS ORGANIZATION.CUSTOMER (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL UNIQUE,
    PASSWORD VARCHAR(255) NOT NULL,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Product table
CREATE TABLE IF NOT EXISTS ORGANIZATION.PRODUCT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(255) NOT NULL,
    PRICE DECIMAL(10, 2) NOT NULL,
    DESCRIPTION TEXT,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order table
CREATE TABLE IF NOT EXISTS ORGANIZATION.ORDER (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    CUSTOMER_ID INT NOT NULL,
    ORDER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TOTAL_AMOUNT DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES ORGANIZATION.CUSTOMER(ID)
);

-- STEP 3: Insert sample data
-- ============================================
-- Insert customers
INSERT IGNORE INTO ORGANIZATION.CUSTOMER (NAME, EMAIL, PASSWORD) VALUES 
    ('John Doe', 'john.doe@example.com', 'password123'),
    ('Jane Smith', 'jane.smith@example.com', 'password123'),
    ('Bob Johnson', 'bob.johnson@example.com', 'password123'),
    ('Alice Williams', 'alice.williams@example.com', 'password123'),
    ('Charlie Brown', 'charlie.brown@example.com', 'password123');

-- Insert products
INSERT IGNORE INTO ORGANIZATION.PRODUCT (NAME, PRICE, DESCRIPTION) VALUES 
    ('Laptop', 999.99, 'High-performance laptop'),
    ('Mouse', 29.99, 'Wireless mouse'),
    ('Keyboard', 79.99, 'Mechanical keyboard'),
    ('Monitor', 299.99, '27-inch 4K monitor'),
    ('Headphones', 149.99, 'Noise-cancelling headphones');

-- Insert orders
INSERT IGNORE INTO ORGANIZATION.ORDER (CUSTOMER_ID, ORDER_DATE, TOTAL_AMOUNT) VALUES 
    (1, '2024-01-15 10:30:00', 999.99),
    (1, '2024-01-20 14:20:00', 29.99),
    (2, '2024-01-18 09:15:00', 379.98),
    (3, '2024-01-22 16:45:00', 149.99),
    (4, '2024-01-25 11:00:00', 1279.97);

-- STEP 4: Query and verify data
-- ============================================

-- Verify current database
SELECT 'Current Database:' AS info, DATABASE() AS value;

-- Count records in each table
SELECT 'CUSTOMER' AS table_name, COUNT(*) AS record_count FROM ORGANIZATION.CUSTOMER
UNION ALL
SELECT 'PRODUCT', COUNT(*) FROM ORGANIZATION.PRODUCT
UNION ALL
SELECT 'ORDER', COUNT(*) FROM ORGANIZATION.ORDER;

-- View all customers
SELECT '=== ALL CUSTOMERS ===' AS section;
SELECT ID, NAME, EMAIL, CREATED_AT FROM ORGANIZATION.CUSTOMER ORDER BY ID;

-- View all products
SELECT '=== ALL PRODUCTS ===' AS section;
SELECT ID, NAME, PRICE, DESCRIPTION FROM ORGANIZATION.PRODUCT ORDER BY PRICE DESC;

-- View all orders with customer names
SELECT '=== ALL ORDERS WITH CUSTOMER INFO ===' AS section;
SELECT 
    o.ID AS order_id,
    c.NAME AS customer_name,
    o.ORDER_DATE,
    o.TOTAL_AMOUNT
FROM ORGANIZATION.ORDER o
JOIN ORGANIZATION.CUSTOMER c ON o.CUSTOMER_ID = c.ID
ORDER BY o.ORDER_DATE DESC;

-- Find customers who placed orders
SELECT '=== CUSTOMERS WHO PLACED ORDERS ===' AS section;
SELECT DISTINCT
    c.ID,
    c.NAME,
    c.EMAIL,
    COUNT(o.ID) AS total_orders
FROM ORGANIZATION.CUSTOMER c
JOIN ORGANIZATION.ORDER o ON c.ID = o.CUSTOMER_ID
GROUP BY c.ID, c.NAME, c.EMAIL
ORDER BY total_orders DESC;

-- Calculate total sales
SELECT '=== SALES SUMMARY ===' AS section;
SELECT 
    COUNT(*) AS total_orders,
    SUM(TOTAL_AMOUNT) AS total_revenue,
    AVG(TOTAL_AMOUNT) AS average_order_value,
    MIN(TOTAL_AMOUNT) AS smallest_order,
    MAX(TOTAL_AMOUNT) AS largest_order
FROM ORGANIZATION.ORDER;

-- ============================================
-- EXPECTED RESULTS:
-- ============================================
-- Current Database: ORGANIZATION
-- CUSTOMER: 5 records
-- PRODUCT: 5 records  
-- ORDER: 5 records
-- Total Revenue: 2839.92
-- ============================================

USE demo;
DROP SCHEMA demo;

USE organization;

CREATE TABLE people (
    taxcode         VARCHAR(30),
    first_name      VARCHAR(30),
    last_name       VARCHAR(30),
    city            VARCHAR(30)
);

SELECT * FROM people;

INSERT INTO people
VALUE  
     ('BRWMRA55B21T234J', 'mary', 'brown', 'verona'),
     ('LBLCLR69T30H745Z', 'charles', 'leblanc', 'paris'), 
     ('BRWGNN41A31B344C', 'giovanni', 'brown', 'verona'),
     ('BRWPRT75C12F205V ', 'pietro', 'brown', 'milan');

-- Query x: we wish to retrieve the cities in which the people named Brown live

SELECT DISTINCT city, taxcode
FROM people
WHERE last_name = 'brown';

USE organization;

SELECT * FROM employee;