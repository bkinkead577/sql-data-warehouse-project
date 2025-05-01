/*

Brian Kinkead
4/29/2025
=======================================================================================

PURPOSE:  Initial data load using bulk load utility into DataWarehoue bronze tables.

WARNING: Will truncate all bronze schema tables.

Parameters:
   None

Usage Example:
     EXEC [Bronze].[load_bronze]
=====================================================================================
*/

CREATE OR ALTER PROC bronze.load_bronze AS

BEGIN 
    DECLARE @start_time DATETIME2, @end_time DATETIME2;
	DECLARE @batch_start DATETIME, @batch_end DATETIME;
	BEGIN TRY

	SET @batch_start = GETDATE();

	--SET NOCOUNT, XACT_ABORT ON;

	PRINT '=========================================='
	PRINT 'Loading Bronze Layer';
	PRINT '=========================================='

	--USE DataWarehouse;
	--GO



	PRINT '--------------------------------------------';
	PRINT 'Loading CRM Tables';
	PRINT '--------------------------------------------';

	SET @start_time = GETDATE();
	PRINT '>> Truncating Table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT '>> Inserting Data into table: bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Data\dwh_project\datasets\source_crm\cust_info.csv'
	WITH ( 
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------';

	--SELECT COUNT(*) FROM bronze.crm_cust_info;

	--SELECT TOP 1000 * FROM bronze.crm_cust_info;



	/******************************************************
	  load prd_info
	*******************************************************/
	SET @start_time = GETDATE();
	PRINT '>> Truncating Table: bronze.[crm_prd_info]';
	TRUNCATE TABLE [Bronze].[crm_prd_info];

	PRINT '>> Inserting Data into table: bronze.[crm_prd_info]';
	BULK INSERT [Bronze].[crm_prd_info]
	FROM 'C:\Data\dwh_project\datasets\source_crm\prd_info.csv'
	WITH ( 
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------';

	--SELECT COUNT(*) FROM [Bronze].[crm_prd_info];

	--SELECT TOP 1000 * FROM [Bronze].[crm_prd_info];

	/******************************************************
	  load crm_sales_detail
	*******************************************************/
	SET @start_time = GETDATE()
	PRINT '>> Truncating Table: bronze.crm_sales_detail';
	TRUNCATE TABLE [Bronze].crm_sales_detail;

	PRINT '>> Inserting Data into table: bronze.crm_sales_detail';
	BULK INSERT [Bronze].crm_sales_detail
	FROM 'C:\Data\dwh_project\datasets\source_crm\sales_details.csv'
	WITH ( 
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------';
	--SELECT COUNT(*) FROM [Bronze].crm_sales_detail;

	--SELECT TOP 1000 * FROM [Bronze].crm_sales_detail;


	/******************************************************
	  load [Bronze].[erp_cust_az12]
	*******************************************************/

	PRINT '--------------------------------------------';
	PRINT 'Loading ERP Tables';
	PRINT '--------------------------------------------';

	SET @start_time = GETDATE()
	PRINT '>> Truncating Table: bronze.[erp_cust_az12]';
	TRUNCATE TABLE [Bronze].[erp_cust_az12]

	PRINT '>> Inserting Data into table: bronze.[erp_cust_az12]';
	BULK INSERT [Bronze].[erp_cust_az12]
	FROM 'C:\Data\dwh_project\datasets\source_erp\CUST_AZ12.csv'
	WITH ( 
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

    SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------';
	--SELECT COUNT(*) FROM [Bronze].[erp_cust_az12];

	--SELECT TOP 1000 * FROM [Bronze].[erp_cust_az12];


	/******************************************************
	  load [Bronze].[erp_loc_a101]
	*******************************************************/
	SET @start_time = GETDATE()
	PRINT '>> Truncating Table: bronze.[erp_loc_a101]';
	TRUNCATE TABLE [Bronze].[erp_loc_a101];

	PRINT '>> Inserting Data into table: bronze.[erp_loc_a101]';
	BULK INSERT [Bronze].[erp_loc_a101]
	FROM 'C:\Data\dwh_project\datasets\source_erp\LOC_A101.csv'
	WITH ( 
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------';
	--SELECT COUNT(*) FROM [Bronze].[erp_loc_a101];

	--SELECT TOP 1000 * FROM [Bronze].[erp_loc_a101];


	/******************************************************
	  load [Bronze].[erp_px_cat_g1v2]
	*******************************************************/
	SET @start_time = GETDATE()
	PRINT '>> Truncating Table: [erp_px_cat_g1v2]';
	TRUNCATE TABLE [Bronze].[erp_px_cat_g1v2];

	PRINT '>> Inserting Data into table: [erp_px_cat_g1v2]';
	BULK INSERT [Bronze].[erp_px_cat_g1v2]
	FROM 'C:\Data\dwh_project\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH ( 
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '------------------------';

	SET @batch_end = GETDATE();

	PRINT '============================================';
	PRINT 'Loading Bronze Layer is Completed';
	PRINT '   - Total Batch Duration: ' + + CAST(DATEDIFF(second, @batch_start, @batch_end) AS NVARCHAR) + ' seconds';
	PRINT '============================================';

	--SELECT COUNT(*) FROM [Bronze].[erp_px_cat_g1v2];

	--SELECT TOP 1000 * FROM [Bronze].[erp_px_cat_g1v2];
	END TRY

	BEGIN CATCH
		PRINT  '======================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message ' + ERROR_MESSAGE();
		PRINT 'Error Number ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '========================================================';
	END CATCH

END 
