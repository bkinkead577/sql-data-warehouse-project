/*
===========================================================================
DDL Script: Create Gold Views
===========================================================================

Script Purpose:
   This script creatwe the Gold Layer in the data warehouse.
   The Gold Layer represents the final dimension and fact tables (Star Schema)

  Each view performs transformations and combines data from the Silver layer 
  to produce a clean, enriched, and business-read dataset.


Usage:
   - These view can be queries directly for analytics and reporting.



*/



--======================================================
-- Create dimension gold.dim_products
--=====================================================

CREATE  VIEW gold.dim_products AS 
  SELECT 
       ROW_NUMBER() OVER (ORDER BY prd_start_dt, prd_key) AS product_key	
       ,[prd_id]  AS product_id
      ,[prd_key] AS product_number
      ,[prd_nm]  AS product_name
	  ,[cat_id]  AS category_id
	   ,pc.cat   AS category
	  ,pc.subcat AS subcategory
      ,[prd_cost] AS cost
      ,[prd_line]  AS product_line
      ,[prd_start_dt] AS [start_date]
	  ,pc.maintenance
  FROM [DataWarehouse].[Silver].[crm_prd_info] AS pn
  LEFT JOIN [Bronze].[erp_px_cat_g1v2] AS pc
  ON pn.cat_id = pc.id
  WHERE prd_end_dt IS NULL;   -- Filter out historical data


--======================================================
-- Create dimension gold.dim_customers
--=====================================================

CREATE VIEW gold.dim_customers AS 
  SELECT 
      ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key
     , ci.[cst_id]  AS customer_id
      ,ci.[cst_key] AS customer_number
      ,ci.[cst_firstname] AS first_name
      ,ci.[cst_lastname] AS last_name
      ,ci.[cst_marital_status] AS marital_status
      ,CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr   -- DRM is Master
	     ELSE COALESCE(ca.gen, 'n/a')
		END AS gender
	  ,ca.bdate AS birthdate
	  ,la.cntry AS country
	 ,ci.[cst_create_date] AS create_date
  FROM [DataWarehouse].[Silver].[crm_cust_info] AS ci
  LEFT JOIN silver.erp_cust_az12 AS ca
  ON ci.cst_key = ca.cid
  LEFT JOIN silver.erp_loc_a101 AS la
  ON ci.cst_key = la.cid;

--======================================================
-- Create dimension gold.fact_sales
--=====================================================

CREATE VIEW gold.fact_sales AS
SELECT  [sls_ord_num] AS order_number
       ,pr.product_key   -- surrogate key
	   ,cu.customer_key    -- surrogate key
      --,[sls_prd_key]
      --,[sls_cust_id]
      ,[sls_order_dt] AS order_date
      ,[sls_ship_dt] AS shipping_date
      ,[sls_due_dt] AS due_date
      ,[sls_sales]  AS sales_amount
      ,[sls_quantity] AS quantity
      ,[sls_price]  AS price
  FROM [DataWarehouse].[Silver].[crm_sales_detail] AS sd
  LEFT JOIN gold.dim_products AS pr
  ON sd.sls_prd_key = pr.product_number
  LEFT JOIN gold.dim_customers AS cu
  ON sd.sls_cust_id = cu.customer_id;
