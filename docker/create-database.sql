-- Create a new database
CREATE
DATABASE bank;
GO

-- Switch to the new database context
USE bank;
GO

-- Enable CDC on the new database
EXEC sys.sp_cdc_enable_db;
GO
-- Create a sample table

CREATE TABLE dbo.client
(
    ID INT PRIMARY KEY,
    NAME NVARCHAR(100),
);
CREATE TABLE dbo.account
(
    ID INT PRIMARY KEY,
    ACC_NUMBER NVARCHAR(100),
    CLIENT_ID int
        constraint CLIENT_ID_FK
            references dbo.client
);

GO

-- Enable CDC on the sample table
EXEC sys.sp_cdc_enable_table
    @source_schema = 'dbo',
    @source_name = 'account',
    @role_name = NULL;

EXEC sys.sp_cdc_enable_table
    @source_schema = 'dbo',
    @source_name = 'client',
    @role_name = NULL;

GO