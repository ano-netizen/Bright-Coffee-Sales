---This is a sample query to demonstrate the connection to the database
SELECT *
 FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1
  LIMIT 150;
-------------------------------------------------------------
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
--4 WHAT PRODUCTS ARE SOLD IN ALL STORES = Coffee,Tea,Drinking Chocolate,Bakery,Flavours,Loose Tea,  Coffee beans,Packaged Chocolate,Branded
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

  SELECT transaction_time,
          COUNT(DISTINCT transaction_time) AS total_transactions
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1
  GROUP BY transaction_time
  ORDER BY transaction_time ASC
  LIMIT 150;
  -----------------------------------------------------------------------
--6
------------------------------------------------------------------------
SELECT COUNT(transaction_qty),
       CASE 
       WHEN HOUR(transaction_time) >6 AND HOUR(transaction_time) <10 THEN 'MORNING RUSH'
       WHEN HOUR(transaction_time) >10 AND HOUR(transaction_time) <12 THEN 'EARLY LUNCH'
       WHEN HOUR(transaction_time) >12 AND HOUR(transaction_time) <16 THEN 'AFTERNOON'
       WHEN HOUR(transaction_time) >16 AND HOUR(transaction_time) <18 THEN 'EVENING'
       ELSE 'LATE NIGHT'
       END AS time_intervals
       FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1
       GROUP BY time_intervals
       ORDER BY COUNT(transaction_qty) DESC;
  --------------------------------------------------------------------------------
  --7 TOP 5 PRODUCTS BY QUANTITY SOLD = COFFEE,TEA,DRINKING CHOCOLATE,BAKERY,FLAVOURS
  ---------------------------------------------------------------------------------
  SELECT product_category,
         SUM(transaction_qty) AS total_quantity_sold
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1
  GROUP BY product_category
  ORDER BY total_quantity_sold DESC
  LIMIT 5;
  -----------------------------------------------------------------------
  --8 TOP 5 PRODUCTS BY REVENUE = COFFEE,TEA,DRINKING CHOCOLATE,BAKERY,FLAVOURS
  -----------------------------------------------------------------------
  SELECT product_category,
         SUM(unit_price*transaction_qty) AS total_revenue
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1
  GROUP BY product_category
  ORDER BY total_revenue DESC
  LIMIT 5;
  ---------------------------------------------------------------------------------------
  --9 TOP 5 PRODUCTS BY REVENUE PER UNIT = COFFEE,TEA,DRINKING CHOCOLATE,BAKERY,FLAVOURS
  ---------------------------------------------------------------------------------------
  SELECT product_category,
         SUM(unit_price*transaction_qty)/SUM(transaction_qty) AS avg_revenue_per_unit
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1
  GROUP BY product_category
  ORDER BY avg_revenue_per_unit DESC
  LIMIT 5;
  --------------------------------------------------------------------------------------
  --10 TOP 5 PRODUCTS BY QUANTITY SOLD PER UNIT = COFFEE,TEA,DRINKING CHOCOLATE,BAKERY,FLAVOURS
  ---------------------------------------------------------------------------------------
  SELECT product_category,
         SUM(transaction_qty)/SUM(transaction_qty) AS avg_quantity_sold_per_unit
  FROM workspace.default.Bright_coffee_shop_analysis_case_study_1_1
  GROUP BY product_category
  ORDER BY avg_quantity_sold_per_unit DESC
  LIMIT 5;
  ------------------------------------------------------------------------------------
  --11 LEAST PERFORMING PRODUCT BY QUANTITY SOLD = FLAVOURS
  ------------------------------------------------------------------------------------
  SELECT product_category,
         SUM(transaction_qty) AS total_quantity_sold
  FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
  WHERE unit_price <"2"
  GROUP BY product_category
  ORDER BY total_quantity_sold ASC;
-----------------------------------------------------------------------------------------------
--12 LEAST PERFORMING PRODUCT BY REVENUE = FLAVOURS
-----------------------------------------------------------------------------------------------
SELECT product_category,
       SUM(unit_price*transaction_qty) AS total_revenue
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
WHERE unit_price <"2"
GROUP BY product_category;
-----------------------------------------------------------------------------------
--13 LEAST PERFORMING PRODUCT BY REVENUE PER UNIT = FLAVOURS
-----------------------------------------------------------------------------------
SELECT product_category,
       SUM(unit_price*transaction_qty)/SUM(transaction_qty) AS avg_revenue_per_unit
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
WHERE unit_price <"2"
GROUP BY product_category;
----------------------------------------------------------------------------------------------
--14 MONTH WITH HIGHEST SALES(REVENUE) = 
----------------------------------------------------------------------------------------------
SELECT MONTHNAME(transaction_date) AS Month,
       SUM(unit_price*transaction_qty) AS total_income
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
GROUP BY Month
ORDER BY total_income DESC
LIMIT 1;
---------------------------------------------------------------------------------------------
--15 REVENUE BY LOCATIONS = 
---------------------------------------------------------------------------------------------
SELECT store_location,
       SUM(unit_price*transaction_qty) AS total_revenue
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
GROUP BY store_location
ORDER BY total_revenue DESC;
--------------------------------------------------------------------------------
--TOP PRODUCT REVENUE IN EACH LOCATION = 
--------------------------------------------------------------------------------
SELECT store_location,
       product_category,
       product_type,
       SUM(unit_price*transaction_qty) AS total_revenue
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
GROUP BY store_location,product_category,product_type
ORDER BY store_location, total_revenue DESC;
-------------------------------------------------------------------------------
--BEST SELLING HOUR IN EACH LOCATION = 
-------------------------------------------------------------------------------
SELECT DISTINCT store_location,
       EXTRACT(HOUR FROM transaction_time) AS hour,
       SUM(unit_price*transaction_qty) AS total_revenue
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
GROUP BY store_location,hour
ORDER BY store_location,hour,total_revenue DESC;

-----------------------------------------------------------------------
---TOTAL REVENUE IN ALL STORES = 
-----------------------------------------------------------------------
SELECT SUM(unit_price*transaction_qty) AS total_revenue
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
ORDER BY total_revenue DESC;

------------------------------------------------------------------------------------
--BEST SELLING DAY OF THE WEEK=
----------------------------------------------------------------------------
SELECT 
    DAYNAME( transaction_date) AS day_of_week,
    SUM(unit_price*transaction_qty) AS total_income
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
GROUP BY DAYNAME(transaction_date)
ORDER BY total_income DESC
LIMIT 1;
----------------------------------------------------------------------

SELECT store_location,
    EXTRACT(HOUR FROM transaction_time) AS sale_hour,
    SUM(unit_price*transaction_qty) AS total_income
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
GROUP BY store_location, EXTRACT(HOUR FROM transaction_time)
ORDER BY store_location, total_income DESC;
