# Troubleshooting: Why No Data in CUSTOMER Table

## Common Causes & Solutions

### 1. **Running Queries Individually (Most Common)**

**Problem**: If you're running queries one at a time, the `USE DEMO;` statement might not persist between queries.

**Solution**: 
- Run the entire SQL file at once, OR
- Use fully qualified table names: `DEMO.CUSTOMER` instead of just `CUSTOMER`
- Always specify the schema when querying: `SELECT * FROM DEMO.CUSTOMER;`

### 2. **Table Created in Wrong Schema**

**Problem**: The table might exist in a different database/schema than where you're querying.

**Check**:
```sql
-- See all schemas
SHOW DATABASES;

-- See tables in DEMO schema
SHOW TABLES FROM DEMO;

-- See tables in current database
SHOW TABLES;
```

**Solution**: Use fully qualified names: `SELECT * FROM DEMO.CUSTOMER;`

### 3. **Inserts Failed Silently**

**Problem**: INSERT statements might have failed due to:
- Duplicate email (UNIQUE constraint)
- Connection issues
- Permission errors

**Check**:
```sql
-- After running inserts, check for warnings/errors
SHOW WARNINGS;

-- Check if inserts actually worked
SELECT COUNT(*) FROM DEMO.CUSTOMER;
```

**Solution**: 
- Use `INSERT IGNORE` to skip duplicates
- Check error messages in your SQL client
- Verify you have INSERT permissions

### 4. **Auto-Commit Disabled**

**Problem**: Some database configurations require explicit COMMIT.

**Solution**:
```sql
-- Add this after inserts (though MySQL auto-commits by default)
COMMIT;
```

### 5. **Wrong Database Connection**

**Problem**: Your SQL client might be connected to a different database.

**Check**:
```sql
SELECT DATABASE();  -- Shows current database
```

**Solution**: 
- Reconnect to the correct database
- In SQLTools/MySQL extension, verify connection settings
- Use `USE DEMO;` before queries

## Step-by-Step Diagnostic Process

Run these queries in order:

```sql
-- Step 1: Check current database
SELECT DATABASE() AS current_database;

-- Step 2: Verify DEMO schema exists
SHOW DATABASES LIKE 'DEMO';

-- Step 3: Check if CUSTOMER table exists in DEMO
SHOW TABLES FROM DEMO;

-- Step 4: Check table structure
DESCRIBE DEMO.CUSTOMER;

-- Step 5: Count records (should be 5)
SELECT COUNT(*) AS total_customers FROM DEMO.CUSTOMER;

-- Step 6: View all records
SELECT * FROM DEMO.CUSTOMER;

-- Step 7: Check for any errors/warnings
SHOW WARNINGS;
```

## Quick Fix: Use Fully Qualified Names

Instead of:
```sql
SELECT * FROM CUSTOMER;
```

Always use:
```sql
SELECT * FROM DEMO.CUSTOMER;
```

This ensures you're querying the correct table regardless of which database is currently selected.

## How to Verify Data Was Inserted

Run this complete check:
```sql
USE DEMO;
SELECT 
    COUNT(*) AS total_rows,
    GROUP_CONCAT(NAME) AS customer_names
FROM DEMO.CUSTOMER;
```

Expected result: `total_rows = 5`

## If Still No Data

1. **Re-run the entire SQL file** from the beginning
2. **Check connection settings** - ensure you're connected to the right MySQL instance
3. **Verify MySQL is running**: `mysql -u root -p -e "SELECT VERSION();"`
4. **Check user permissions**: Ensure your MySQL user has CREATE, INSERT, SELECT permissions
5. **Look for error messages** in your SQL client's output panel

