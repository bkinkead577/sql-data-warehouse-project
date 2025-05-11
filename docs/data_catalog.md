# Data Dictionary for Gold Layer

## Overview

The Gold Layer is the business-level representation, structured to support analytical and reporting use cases, 
It consists of **dimension tables** and **fact tables** for specific business metrics.

### 1. gold.dim_customers

* **Purpose:** Stores customer details enriched with demographic and geographic data.\
* **Columns:**  

| Column Name | Data Type | Description |
| ------------ | ----------- | ----------- |
| customer_key | INT | Surrogate key uniquely identifying each customer record in the dimension table |
| customer_id | INT | Unique numerical identifier assigned to each customer |
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking an referencing | 
| first_name | NARCHAR(50) | The customer's first name, as recorded in the system |
| last_name | NVARCHAR(50) | The customer's last name or family name |
| country | NVARCHAR(50) | The country of residence for the customer (e.g., 'Ireland') |
| marital_status | NVARCHAR(50) | The marital status of the customer (e.g., 'Married', 'Single', 'n/a') |
| gender | NVARCHAR(50) | The gender of the customer (e.g., 'Male', 'Female', 'n/a') |


### 2. gold.dim_products

* **Purpose:** Provides information about the products and their attributes.\
* **Columns:**  

| Column Name | Data Type | Description |
| ------------ | ----------- | ----------- |
| customer_key | INT | Surrogate key uniquely identifying each customer record in the dimension table |
| customer_id | INT | Unique numerical identifier assigned to each customer |
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking an referencing | 
| first_name | NARCHAR(50) | The customer's first name, as recorded in the system |
| last_name | NVARCHAR(50) | The customer's last name or family name |
| country | NVARCHAR(50) | The country of residence for the customer (e.g., 'Ireland') |
| marital_status | NVARCHAR(50) | The marital status of the customer (e.g., 'Married', 'Single', 'n/a') |
| gender | NVARCHAR(50) | The gender of the customer (e.g., 'Male', 'Female', 'n/a') |

### 3. gold.fact_sales

* **Purpose:** Stores transactional sales data for analytical purposes.\
* **Columns:**  

| Column Name | Data Type | Description |
| ------------ | ----------- | ----------- |
| order_number | NARCHAR(50) | A unique alphanumeric identifier for each sales order (e.g., 'SO54496'). |
| product_key | INT | Surrogate key linking the order to the product dimension table. |
| customer_key | NVARCHAR(50) | Surrogate key linking the order to the customer dimension table. | 
| order_date | DATE | The date the order was placed. |
| shipping_date | DATE | The date when the order was shipped to the customer. |
| due_date | DATE | The date when the order was due. |
| sales_amount | INT | The total monetary value of the sale for the line item, in whole currency units (e.g., 25).  |
| quantity | INT | The number of units of the product ordered for the line item (e.g., 1). |
| price | INT | The price per unit for the line item, in whole currency units (e.g., 25). |
