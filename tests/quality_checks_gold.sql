--=============================================
  -- Check Foreign Key Integrity
--==============================================
  SELECT * FROM gold.fact_sales as f
  LEFT JOIN gold.dim_customers as c
   ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products AS p
  ON f.product_key = p.product_key
   WHERE c.customer_key IS NULL
    OR f.product_key IS NULL;


--===============================================
-- Checking dim_customers for duplicates
--============================================
SELECT 
   customer_key,
COUNT(*) AS duplicate_recors
FROM gold.dim_customers
HAVING COUNT(*) > 1;


--===============================================
-- Checking gold.product_key
--============================================
-- Check for Uniqueness of Product key 
SELECT 
   product_key,
COUNT(*) as duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


