# Quick Start: Testing SQL in Cursor IDE

## Complete Example File: `complete_example.sql`

This file contains a **complete, working SQL example** from beginning to end that you can use to test SQL in Cursor IDE.

## What the Example Does

1. ✅ Creates a database schema called `DEMO`
2. ✅ Creates 3 tables: CUSTOMER, PRODUCT, ORDER
3. ✅ Inserts sample data (5 customers, 5 products, 5 orders)
4. ✅ Runs various queries to demonstrate SQL capabilities
5. ✅ Shows joins, aggregations, and data relationships

## How to Run It

### Option 1: Using SQL Extension (Recommended)

1. **Install SQL Extension:**
   - Press `Ctrl+Shift+X` to open Extensions
   - Search for "SQLTools" and install it
   - Or install "MySQL" extension if using MySQL

2. **Connect to Database:**
   - Click SQLTools icon in sidebar
   - Click "Add New Connection"
   - Enter your database details:
     - Host: `localhost` (or your server)
     - Port: `3306` (MySQL) or `5432` (PostgreSQL)
     - Database: Leave empty or use existing database
     - Username: `root` (or your username)
     - Password: Your password

3. **Run the SQL File:**
   - Open `complete_example.sql`
   - Right-click in the editor → "Run Query" or "Execute Query"
   - Select your connection when prompted
   - View results in the output panel

### Option 2: Using Command Line

**For MySQL:**
```powershell
mysql -u root -p < complete_example.sql
```

**For PostgreSQL:**
```powershell
psql -U postgres -f complete_example.sql
```

### Option 3: Run Individual Queries

1. Select a specific query (e.g., `SELECT * FROM DEMO.CUSTOMER;`)
2. Right-click → "Run Query"
3. See results for that specific query

## Expected Results

After running `complete_example.sql`, you should see:

- ✅ 5 customers inserted
- ✅ 5 products inserted  
- ✅ 5 orders inserted
- ✅ Various query results showing relationships between data
- ✅ Sales summary with totals

## Verify It Worked

Run this query to verify:
```sql
SELECT 
    (SELECT COUNT(*) FROM DEMO.CUSTOMER) AS customers,
    (SELECT COUNT(*) FROM DEMO.PRODUCT) AS products,
    (SELECT COUNT(*) FROM DEMO.ORDER) AS orders;
```

Expected output: `customers: 5, products: 5, orders: 5`

## Troubleshooting

**If you get connection errors:**
- Make sure your database server is running
- Check username/password are correct
- Verify the port number matches your database

**If tables already exist:**
- The script uses `IF NOT EXISTS` so it's safe to run multiple times
- Use `DROP SCHEMA DEMO;` first if you want to start fresh

**If you see no data:**
- Make sure you're connected to the right database
- Check that all statements executed successfully
- Look for error messages in the output panel

## Next Steps

Once this example works, you can:
- Modify the queries to experiment
- Add your own tables and data
- Practice writing JOINs, WHERE clauses, aggregations
- Build your e-commerce database based on `data_dictionary.txt`

## File Structure

- `complete_example.sql` - Complete working example (use this!)
- `demo_sql_01.sql` - Your original file with troubleshooting
- `data_dictionary.txt` - Your project's data model reference

