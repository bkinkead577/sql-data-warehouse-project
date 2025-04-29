/*
 Create Database and schemas

 Script Purpose:
   Drop and create database 'DataWarehouse' and three schemas 'Bronze', 'Silver', and 'Gold'.

  WARNING: 
   Running this script will drop the DataWarehouse database. 



*/

USE master
GO


IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'Datawarehouse')
	BEGIN
	  ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	  DROP DATABASE Datawarehouse;
	END;
GO

CREATE DATABASE DataWarehouse;
GO


USE Datawarehouse;
GO


CREATE SCHEMA Bronze;
GO

CREATE SCHEMA Silver;
GO

CREATE SCHEMA Gold;
GO




