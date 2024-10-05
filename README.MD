docker-compose -f .\docker\docker-compose.yml up

to create connector
POST http://localhost:8083/connectors
as body use content from docker\mssql-connector.json

to delete connector
DELETE http://localhost:8083/connectors/mssql-connector



