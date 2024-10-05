#!/bin/bash
# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to start
sleep 10s

# Start SQL Server Agent
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P YourStrong!Passw0rd -Q "EXEC sp_configure 'show advanced options', 1; RECONFIGURE; EXEC sp_configure 'Agent XPs', 1; RECONFIGURE;"

# Run the setup script to create the database and enable CDC
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P YourStrong!Passw0rd -d master -i create-database.sql

# Keep the container running
wait


