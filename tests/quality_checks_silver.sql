/*

5/4/2025
Brian Kinkead

 PURPOSE: Data Checks for Silver data after loading from bronze.


*/



---------------------------------------------
-- Check for NULL or duplicates in PK
---------------------------------------------
SELECT 
   cst_id,
   COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1
  OR cst_id IS NULL;


--------------------------------------------
-- Check for unwanted spaces 
--------------------------------------------
SELECT cst_firstname 
FROM silver.crm_cust_info 
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_firstname 
FROM silver.crm_cust_info 
WHERE cst_gndr != TRIM(cst_gndr);

SELECT cst_lastname 
FROM silver.crm_cust_info 
WHERE cst_lastname != TRIM(cst_lastname);


-------------------------------------------
-- Data Standardization & Consistency
--------------------------------------------
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;

SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info;


-------------------------------------------------------
-- crm_prd_info  checks 
-------------------------------------------------------

  SELECT 
   prd_id,
   COUNT(*) 
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1
  OR prd_id IS NULL;


  -- Data Standardization & Consistenct 
  SELECT DISTINCT prd_line 
  FROM silver.crm_prd_info;

  -- Check for invalid dates 
  SELECT * 
  FROM silver.crm_prd_info
  WHERE prd_end_dt < prd_start_dt;


  SELECT TOP 1000 * 
  FROM silver.crm_prd_info;

  --------------------------------------------
-- Check business rules 
----------------------------------------------
SELECT * 
FROM silver.crm_sales_detail
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL 
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0;
 

-- Check for invalid values 
SELECT * 
FROM silver.erp_cust_az12
WHERE cid LIKE 'NAS%';
 
 -- Check bdate 
 SELECT * 
 FROM silver.[erp_cust_az12]
 WHERE bdate < '1924-01-01' 
  or bdate > GETDATE();

-- Data Standardization & Consistency
SELECT DISTINCT gen 
FROM silver.[erp_cust_az12];

SELECT * FROM silver.erp_cust_az12;


SELECT DISTINCT cntry 
FROM silver.[erp_loc_a101]
ORDER BY 1;


-- Check for unwanted spaces
SELECT * 
FROM silver.[erp_px_cat_g1v2]
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat)
 OR maintenance != TRIM(maintenance);


 -- Data standardization & consistency
 SELECT DISTINCT cat 
 FROM silver.[erp_px_cat_g1v2];

