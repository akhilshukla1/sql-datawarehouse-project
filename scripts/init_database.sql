/******************************************************************************************
 Script: Recreate_DataWarehouse.sql
 Author: Akhil Shukla
 
 Description:
    - Drops the existing 'DataWarehouse' database if it exists.
    - Recreates it from scratch.
    - Sets up three schemas: bronze, silver, and gold.

 Purpose:
    - To ensure a clean, consistent database environment for development/testing.
    - Implements a medallion architecture used in data engineering:
        • bronze: stores raw ingested data
        • silver: stores cleaned/transformed data
        • gold: stores analytics-ready data

 WARNING:
    ⚠️ This script will PERMANENTLY DELETE the 'DataWarehouse' database.
    ⚠️ All existing data, tables, views, and objects will be lost.
    ⚠️ Do NOT use in production without taking a full backup.
    ⚠️ Intended only for development or testing environments.

 Requirements:
    - SQL Server environment (SSMS or equivalent)
    - Appropriate permissions to drop/create databases and schemas

 Usage:
    1. Open in SSMS or your preferred SQL tool.
    2. Execute the entire script to recreate the environment.

 Notes:
    - GO statements are used to separate batches.
    - Schema setup follows the medallion architecture pattern.
******************************************************************************************/

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
