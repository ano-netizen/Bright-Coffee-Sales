-This is a sample query to demonstrate the connection to the database
SELECT*
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

------------------------------------------------------------
-- 1.DATE RANGE OF TRANSACTIONS = 2023-01-01 TO 2023-06-30
-------------------------------------------------------------
  --When was the the first transaction? 2023-01-01
  SELECT MIN(transaction_date) AS first_transaction_date
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1;

  --When was the last transaction? 2023-06-30
  SELECT MAX(transaction_date) AS last_transaction_date
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1;

------------------------------------------------------
--2 NUMBER OF STORES = 3
------------------------------------------------------
  --How many stores are there? 
  SELECT COUNT(DISTINCT store_location) AS total_stores
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1;
----------------------------------------------------------------
  --3 STORE LOCATIONS = Lower Manhattan, Hell's Kitchen, Astoria
  -------------------------------------------------------------------
  --Where are the stores located ?
  SELECT DISTINCT store_location
  FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;
  ------------------------------------------------------------------------
---4 WHAT PRODUCTS ARE SOLD IN ALL STORES = Coffee,Tea,Drinking Chocolate,Bakery,Flavours,Loose Tea,  Coffee beans,Packaged Chocolate,Branded
  -----------------------------------------------------------------------
  --What products are sold in all store?
  SELECT DISTINCT product_category 
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1;

  SELECT DISTINCT product_detail
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1;

  SELECT DISTINCT product_category AS catergory,
                  product_detail AS product_name,
                  product_type
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1;

  -------------------------------------------------------------------------
  --5 OPPERATING TIMES:
  -------------------------------------------------------------------------
  SELECT store_location,
          MIN(transaction_time) AS earliest_time,
          MAX(transaction_time) AS latest_time
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1
  GROUP BY store_location;
  -------------------------------------------------------------------------
--- Checking product prices
  --------------------------------------------------------------------------
  SELECT MIN(unit_price) AS Cheapest_price
  FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

  SELECT MAX(unit_price) AS Most_expensive_price
  FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;
  -----------------------------------------------------------------------
  SELECT *
  FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

  SELECT transaction_id,
         transaction_date,
         Dayname(transaction_date) AS Day_of_week,
         Monthname(transaction_date) AS Month_name,
         transaction_qty*unit_price AS Rev_per_transaction
  FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;
  ----------------------------------------------------------------------------
  SELECT COUNT(*)
  FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

  SELECT 
  ---Dates
         transaction_date,
         Dayname(transaction_date) AS Day_of_week,
         Monthname(transaction_date) AS Month_name,
         Dayofmonth(transaction_date) AS Day_of_month,
         ---Weekdays

         CASE 
              WHEN Dayname(transaction_date) IN ('Sat','Sun') THEN 'Weekend'
              ELSE 'Weekday'
         END AS day_classification,
         ---Times
         date_format(transaction_time,'HH:mm:ss') AS purchase_time,
        ----Transaction times
         CASE 
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '00:00:00' AND '05:59:59' THEN 'Closed'
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning Rush'
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '16:00:00' AND '20:59:59' THEN 'Evening'
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '21:00:00' AND '23:59:59' THEN 'Night'
              ELSE 'Closed'
              END AS Time_bucket,

----Counts
         COUNT(DISTINCT transaction_id) AS Number_of_sales,
         COUNT(DISTINCT store_id) AS Number_of_stores,
         COUNT(DISTINCT product_id) AS Number_of_products,
         
  ----Revenue
         SUM(transaction_qty*unit_price) AS Revenue_per_day,

         CASE 
              WHEN SUM(transaction_qty*unit_price)<=100 THEN 'Low spender'
              WHEN SUM(transaction_qty*unit_price) BETWEEN 100 AND 500 THEN 'Medium spender'
              ELSE 'High spender' 
         END AS Revenue_classification,

         --------Catergorical data
         product_category,
         store_location,
         product_detail

  ---Source
  FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
  GROUP BY transaction_date,
           Dayname(transaction_date),
           Monthname(transaction_date),
           date_format(transaction_time,'HH:mm:ss'),
           CASE 
              WHEN Dayname(transaction_date) IN ('Sat','Sun') THEN 'Weekend'
              ELSE 'Weekday'
         END,
           CASE 
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '00:00:00' AND '05:59:59' THEN 'Closed'
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning Rush'
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '16:00:00' AND '20:59:59' THEN 'Evening'
              WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '21:00:00' AND '23:59:59' THEN 'Night'
              ELSE 'Closed'
              END,
           Dayofmonth(transaction_date),
           product_category,
          product_detail,
          store_location;