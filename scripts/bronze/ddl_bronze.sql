/*
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
DDL Script: Create Bronze Tables
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables
    if they already exist.
    Run this scripts to re-define the DDL structure of 'bronze' Tables
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/


IF OBJECT_ID('bronze.email_campaigns', 'U') IS NOT NULL
    DROP TABLE bronze.email_campaigns;
CREATE TABLE bronze.email_campaigns (
    campaign_id INT PRIMARY KEY,
    campaign_name NVARCHAR(50),
    send_date DATE,
    email_subject NVARCHAR(50),
    send_hour INT,
    category NVARCHAR(50)
);


IF OBJECT_ID('bronze.email_campaign_performance', 'U') IS NOT NULL
    DROP TABLE bronze.email_campaign_performance;
CREATE TABLE bronze.email_campaign_performance (
    campaign_id INT PRIMARY KEY,
    total_sent INT,
    total_opens INT,
    total_clicks INT,
    total_unsubscribes INT
);


IF OBJECT_ID('bronze.email_users', 'U') IS NOT NULL
    DROP TABLE bronze.email_users;
CREATE TABLE bronze.email_users (
    user_id INT PRIMARY KEY,
    signup_date DATE,
    device_type NVARCHAR(50),
    region NVARCHAR(50),
    is_active BIT
);


IF OBJECT_ID('bronze.email_email_engagement') IS NOT NULL
    DROP TABLE bronze.email_email_engagement;
CREATE TABLE bronze.email_email_engagement (
    engagement_id INT PRIMARY KEY,
    user_id INT,
    campaign_id INT,
    opened BIT,
    clicked BIT,
    unsubscribe BIT,
    open_time DATETIME
);


IF OBJECT_ID('bronze.email_unsubscribes', 'U') IS NOT NULL
    DROP TABLE bronze.email_unsubscribes;
CREATE TABLE bronze.email_unsubscribes (
    unsubscribe_id INT PRIMARY KEY,
    user_id INT,
    campaign_id INT,
    unsubscribe_date DATE,
    reason NVARCHAR(50)
);