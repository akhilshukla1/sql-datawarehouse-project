/*
==================================================================================
Procedure Name : bronze.load_bronze
Purpose        : Load raw data from CSV files into BRONZE layer staging tables.
                 This process is part of the Data Warehouse ETL pipeline.
Warning        : This procedure will TRUNCATE existing data in the BRONZE layer
                 and perform BULK INSERT operations. DO NOT run on live tables
                 without backup or downstream control.
Author         : Akhil Shukla
Created On     : 23/06/2025
==================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;

    BEGIN TRY
        SET @start_time = GETDATE();
        PRINT '===== STARTING BRONZE LAYER LOADING PROCESS =====';

        -- ==============================================
        -- Load crm_cust_info
        -- ==============================================
        PRINT 'Loading: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM 'E:\DataWarehouseProject\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- ==============================================
        -- Load crm_prd_info
        -- ==============================================
        PRINT 'Loading: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'E:\DataWarehouseProject\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- ==============================================
        -- Load crm_sales_details
        -- ==============================================
        PRINT 'Loading: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'E:\DataWarehouseProject\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- ==============================================
        -- Load erp_cust_az12
        -- ==============================================
        PRINT 'Loading: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'E:\DataWarehouseProject\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- ==============================================
        -- Load erp_loc_a101
        -- ==============================================
        PRINT 'Loading: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'E:\DataWarehouseProject\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- ==============================================
        -- Load erp_px_cat_g1v2
        -- ==============================================
        PRINT 'Loading: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'E:\DataWarehouseProject\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        -- Log success and duration
        SET @end_time = GETDATE();
        PRINT 'All bronze tables loaded successfully.';
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    END TRY
    BEGIN CATCH
        -- Error handling and logging
        PRINT '==================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR STATE  : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==================================';
    END CATCH
END;
