# How to Select a Database

## Method 1: Using SQL `USE` Statement (MySQL/MariaDB/SQL Server)

Add this at the beginning of your SQL file or before running queries:

```sql
USE database_name;
```

**Example:**
```sql
USE DEMO;
CREATE TABLE CUSTOMER (...);
```

## Method 2: Command Line - Specify Database on Connection

### MySQL/MariaDB:
```powershell
# Connect directly to a specific database
mysql -u root -p database_name

# Or specify database when running SQL file
mysql -u root -p database_name < demo_sql_01.sql
```

### PostgreSQL:
```powershell
# Connect directly to a specific database
psql -U postgres -d database_name

# Or specify database when running SQL file
psql -U postgres -d database_name -f demo_sql_01.sql
```

### SQL Server:
```powershell
# Connect directly to a specific database
sqlcmd -S localhost -U sa -P password -d database_name

# Or specify database when running SQL file
sqlcmd -S localhost -U sa -P password -d database_name -i demo_sql_01.sql
```

## Method 3: In SQL Extensions (SQLTools, MySQL Extension, etc.)

### SQLTools Extension:
1. Click the SQLTools icon in the sidebar
2. Right-click on your connection
3. Select "Set as Active Connection"
4. When adding a connection, specify the database name in the "Database" field

### MySQL Extension:
1. Open Command Palette (`Ctrl+Shift+P`)
2. Type "MySQL: Set Active Connection"
3. Select your connection
4. The database specified in your connection settings will be used

## Method 4: Fully Qualified Table Names

Instead of selecting a database, you can reference tables with their full path:

```sql
-- MySQL
SELECT * FROM database_name.table_name;

-- PostgreSQL
SELECT * FROM database_name.schema_name.table_name;
```

## Quick Reference

| Database System | Select Database Command |
|----------------|------------------------|
| MySQL/MariaDB | `USE database_name;` |
| PostgreSQL | `\c database_name` |
| SQL Server | `USE database_name; GO` |
| SQLite | Not needed (file-based) |

## Best Practices

1. **Always specify database**: Use `USE database_name;` at the start of your SQL files
2. **Check current database**: 
   - MySQL: `SELECT DATABASE();`
   - PostgreSQL: `SELECT current_database();`
   - SQL Server: `SELECT DB_NAME();`
3. **In connection settings**: Always specify the database name when configuring connections in IDE extensions

