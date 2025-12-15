/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Stored Procedure: Load Bronze Layer (Source -> Bronze)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the BULK INSERT command to load data from CSV files to bronze tables.

    Parameters:
        None.
        This stored procedure does not accept any parameters or return any values.

    Usage Example:
        EXEC bronze.load_bronze;
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
    BEGIN
        DECLARE @start_time DATETIME,
                @end_time DATETIME,
                @batch_start_time DATETIME,
                @batch_end_time DATETIME;

        BEGIN TRY
            SET @batch_start_time = GETDATE();
            PRINT '================================================';
            PRINT 'Loading Bronze Layer';
            PRINT '================================================';
            PRINT '';

            PRINT '-------------------------------------------------';
            PRINT 'Loading EMAIL TABLES';
            PRINT '-------------------------------------------------';

            SET @start_time = GETDATE();
            PRINT '>> Truncating Table: bronze.email_campaigns.';
            TRUNCATE TABLE bronze.email_campaigns;

            PRINT '>> Inserting Data Into: bronze.email_campaigns';
            BULK INSERT bronze.email_campaigns
            FROM 'C:\Users\rache\Code\github.com\AnalyticsEngineer\dwh_projects\email_marketing_data_warehouse\datasets\Campaigns.csv'
            WITH (
                FIRSTROW  = 2,
                FIELDTERMINATOR  = ',',
                TABLOCK
                );
            SET @end_time = GETDATE();
            PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
            PRINT '-------------------------------------------------';

            SET @start_time = GETDATE();
            PRINT '>> Truncating Table: bronze.email_campaign_performance';
            TRUNCATE TABLE bronze.email_campaign_performance;

            PRINT '>> Inserting Data Into: bronze.email_campaign_performance';
            BULK INSERT bronze.email_campaign_performance
            FROM 'C:\Users\rache\Code\github.com\AnalyticsEngineer\dwh_projects\email_marketing_data_warehouse\datasets\Campaign_Performance.csv'
            WITH (
                FIRSTROW  = 2,
                FIELDTERMINATOR  = ',',
                TABLOCK
                );
            SET @end_time = GETDATE();
            PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
            PRINT '-------------------------------------------------';

            SET @start_time = GETDATE();
            PRINT '>> Truncating Table: bronze.email_users';
            TRUNCATE TABLE bronze.email_users;

            PRINT '>> Inserting Data Into: bronze.email_users';
            BULK INSERT bronze.email_users
            FROM 'C:\Users\rache\Code\github.com\AnalyticsEngineer\dwh_projects\email_marketing_data_warehouse\datasets\Users.csv'
            WITH (
                FIRSTROW  = 2,
                FIELDTERMINATOR  = ',',
                TABLOCK
                );
            SET @end_time = GETDATE();
            PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
            PRINT '-------------------------------------------------';

            SET @start_time = GETDATE();
            PRINT '>> Truncating Table: bronze.email_email_engagement';
            TRUNCATE TABLE bronze.email_email_engagement;

            PRINT '>> Inserting Data Into: bronze.email_email_engagement';
            BULK INSERT bronze.email_email_engagement
            FROM 'C:\Users\rache\Code\github.com\AnalyticsEngineer\dwh_projects\email_marketing_data_warehouse\datasets\Email_Engagement.csv'
            WITH (
                FIRSTROW  = 2,
                FIELDTERMINATOR  = ',',
                TABLOCK
                );
            SET @end_time = GETDATE();
            PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
            PRINT '-------------------------------------------------';

            SET @start_time = GETDATE();
            PRINT '>> Truncating Table: bronze.email_unsubscribes';
            TRUNCATE TABLE bronze.email_unsubscribes;

            PRINT '>> Inserting Data Into: bronze.email_unsubscribes';
            BULK INSERT bronze.email_unsubscribes
            FROM 'C:\Users\rache\Code\github.com\AnalyticsEngineer\dwh_projects\email_marketing_data_warehouse\datasets\Unsubscribes.csv'
            WITH (
                FIRSTROW  = 2,
                FIELDTERMINATOR  = ',',
                TABLOCK
                );
            SET @end_time = GETDATE();
            PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
            PRINT '-------------------------------------------------';
        END TRY
        BEGIN CATCH
            PRINT '===========================================';
            PRINT 'ERROR OCCURED DURING BRONZE LAYER LOADING'
            PRINT 'Error Message' + CAST (ERROR_MESSAGE() AS NVARCHAR);
            PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
            PRINT '===========================================';
        END CATCH
    END

    EXEC bronze.load_bronze;