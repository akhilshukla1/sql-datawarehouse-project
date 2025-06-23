USE master;
go

--drop and recreate the 'DataWarehouse' databse

IF EXISTS( SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
go

--create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse
GO

--create schemas
CREATE SCHEMA bronze;
GO                    --GO-->seperate batches when working with multiple sql statements
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO 
