# PowerShell script to run SQL queries
# Usage: .\run_sql.ps1 -DatabaseType "mysql" -QueryFile "demo_sql_01.sql"

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("mysql", "postgresql", "sqlserver", "sqlite")]
    [string]$DatabaseType,
    
    [Parameter(Mandatory=$true)]
    [string]$QueryFile,
    
    [string]$Host = "localhost",
    [string]$Database = "",
    [string]$Username = "",
    [string]$Password = ""
)

$query = Get-Content $QueryFile -Raw

switch ($DatabaseType) {
    "mysql" {
        if ($Username -and $Password -and $Database) {
            mysql -h $Host -u $Username -p$Password $Database -e $query
        } else {
            Write-Host "Usage: .\run_sql.ps1 -DatabaseType mysql -QueryFile demo_sql_01.sql -Host localhost -Database your_db -Username root -Password your_pass"
        }
    }
    "postgresql" {
        if ($Username -and $Database) {
            $env:PGPASSWORD = $Password
            psql -h $Host -U $Username -d $Database -c $query
        } else {
            Write-Host "Usage: .\run_sql.ps1 -DatabaseType postgresql -QueryFile demo_sql_01.sql -Host localhost -Database your_db -Username postgres -Password your_pass"
        }
    }
    "sqlserver" {
        if ($Username -and $Password -and $Database) {
            sqlcmd -S $Host -U $Username -P $Password -d $Database -Q $query
        } else {
            Write-Host "Usage: .\run_sql.ps1 -DatabaseType sqlserver -QueryFile demo_sql_01.sql -Host localhost -Database your_db -Username sa -Password your_pass"
        }
    }
    "sqlite" {
        sqlite3 $Database $query
    }
}

