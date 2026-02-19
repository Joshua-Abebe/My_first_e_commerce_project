# How to Run SQL Queries in Cursor IDE

## Method 1: Using SQL Extensions (Recommended)

### Step 1: Install SQL Extension
1. Press `Ctrl+Shift+X` to open Extensions
2. Search for one of these:
   - **SQLTools** (supports multiple databases)
   - **MySQL** (for MySQL/MariaDB)
   - **PostgreSQL** (for PostgreSQL)
   - **SQL Server (mssql)** (for SQL Server)

### Step 2: Configure Database Connection
1. After installation, click the SQLTools icon in the sidebar
2. Click "Add New Connection"
3. Select your database type
4. Enter connection details:
   - Host
   - Port
   - Database name
   - Username
   - Password

### Step 3: Run Queries
1. Open your SQL file (`demo_sql_01.sql`)
2. Right-click in the editor and select "Run Query" or use the command palette (`Ctrl+Shift+P`)
3. Select your connection when prompted

## Method 2: Using Command Line

### For MySQL/MariaDB:
```powershell
mysql -h localhost -u root -p your_database_name < demo_sql_01.sql
```

### For PostgreSQL:
```powershell
psql -h localhost -U postgres -d your_database_name -f demo_sql_01.sql
```

### For SQL Server:
```powershell
sqlcmd -S localhost -U sa -P your_password -d your_database_name -i demo_sql_01.sql
```

## Method 3: Using the PowerShell Script

A helper script `run_sql.ps1` is provided. Example usage:

```powershell
.\run_sql.ps1 -DatabaseType mysql -QueryFile demo_sql_01.sql -Host localhost -Database your_db -Username root -Password your_pass
```

## Quick Tips

- **Execute Selected Text**: Most SQL extensions allow you to select specific SQL statements and run only those
- **Keyboard Shortcuts**: Check the extension documentation for shortcuts (often `Ctrl+E` or `F5`)
- **Multiple Statements**: Some extensions support running multiple statements at once
- **Results View**: Results typically appear in a panel below or beside the editor

## Troubleshooting

- **Connection Issues**: Ensure your database server is running
- **Authentication**: Double-check username/password
- **File Path**: Use absolute paths if relative paths don't work
- **Permissions**: Ensure your database user has necessary permissions

