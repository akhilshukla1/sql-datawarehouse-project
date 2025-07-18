-- =============================================
-- Author      : Akhil Shukla
-- File Name   : ddl_bronze.sql
-- Purpose     : Drops and recreates all bronze-layer tables 
--               for the Data Warehouse project.
--               These tables act as raw data landing zones 
--               for both CRM and ERP source systems.
--
-- WARNING     : This script will permanently DROP all existing 
--               tables in the bronze schema and recreate them. 
--               Any existing data will be lost.
--               Use with caution in production environments.
-- =============================================

-- CRM Tables
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO
CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);
GO

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO
CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt NVARCHAR(50),
    prd_end_dt NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num   VARCHAR(50),
    sls_prd_key   VARCHAR(50),
    sls_cust_id   INT,
    sls_order_dt  NVARCHAR(50),
    sls_ship_dt   NVARCHAR(50),
    sls_due_dt    NVARCHAR(50),
    sls_sales     INT,
    sls_quantity  INT,
    sls_price     INT
);
GO

-- ERP Tables
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO
CREATE TABLE bronze.erp_cust_az12 (
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(10)
);
GO

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO
CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO
