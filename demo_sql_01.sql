CREATE SCHEMA IF NOT EXISTS ORGANIZATION;

-- Select/Use the database
USE ORGANIZATION;

-- Create table with explicit schema qualification
CREATE TABLE IF NOT EXISTS ORGANIZATION.CUSTOMER (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL UNIQUE,
    PASSWORD VARCHAR(255) NOT NULL,
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert data with explicit schema qualification
-- Using INSERT IGNORE to skip duplicates if running multiple times
INSERT IGNORE INTO ORGANIZATION.CUSTOMER (NAME, EMAIL, PASSWORD) VALUES ('John Doe', 'john.doe@example.com', 'password');
INSERT IGNORE INTO ORGANIZATION.CUSTOMER (NAME, EMAIL, PASSWORD) VALUES ('Jane Doe', 'jane.doe@example.com', 'password');
INSERT IGNORE INTO ORGANIZATION.CUSTOMER (NAME, EMAIL, PASSWORD) VALUES ('Jim Doe', 'jim.doe@example.com', 'password');
INSERT IGNORE INTO ORGANIZATION.CUSTOMER (NAME, EMAIL, PASSWORD) VALUES ('Jill Doe', 'jill.doe@example.com', 'password');
INSERT IGNORE INTO ORGANIZATION.CUSTOMER (NAME, EMAIL, PASSWORD) VALUES ('Jack Doe', 'jack.doe@example.com', 'password');

-- ============================================
-- DIAGNOSTIC QUERIES - Run these to troubleshoot
-- ============================================

-- 1. Confirm your current database/schema:
SELECT DATABASE() AS current_database;

-- 2. List all schemas/databases:
SHOW DATABASES;

-- 3. List all tables in ORGANIZATION schema:
SHOW TABLES FROM ORGANIZATION;

-- 4. List all tables in current database:
SHOW TABLES;

-- 5. Check if table exists in ORGANIZATION schema:
SELECT COUNT(*) AS table_exists 
FROM information_schema.tables 
WHERE table_schema = 'ORGANIZATION' AND table_name = 'CUSTOMER';

-- 6. Count records in CUSTOMER table (with schema qualification):
SELECT COUNT(*) AS customer_count FROM ORGANIZATION.CUSTOMER;

-- 7. View all CUSTOMER records (with schema qualification):
SELECT * FROM ORGANIZATION.CUSTOMER;

-- 8. Check for any insert errors (if using error logging):
-- SHOW WARNINGS;