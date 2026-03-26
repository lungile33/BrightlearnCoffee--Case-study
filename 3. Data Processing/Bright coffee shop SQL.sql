---------------------------------------------------------------------------------------
-- BRIGHT COFFEE SHOP CODING
-----------------------------------------------------------------------------------------
--1. I want to see my table in the code to start exploryting each column
SELECT* 
FROM `case_study`.`default`.`bright_coffee_shop` 
LIMIT 100;

--2.Checking the Date Range
SELECT MIN(transaction_date) AS start_date
FROM `case_study`.`default`.`bright_coffee_shop`; 

--3.When last did they collect data 
SELECT MAX(transaction_date) AS latest_date
FROM `case_study`.`default`.`bright_coffee_shop`;

---4.Checking how many customers do we have
SELECT DISTINCT COUNT(transaction_id) AS number_of_rows
FROM `case_study`.`default`.`bright_coffee_shop`; 

---5.Counting Unique product_id
SELECT DISTINCT COUNT(transaction_id)
FROM `case_study`.`default`.`bright_coffee_shop`;

--6.Transaction count per store
SELECT store_location, count(transaction_id) AS number_of_transaction
FROM `case_study`.`default`.`bright_coffee_shop`
GROUP BY store_location;

--7.Checking store location 

SELECT DISTINCT store_location
FROM `case_study`.`default`.`bright_coffee_shop`;

--8.Checking products sold at our stores - 9 different products
SELECT DISTINCT product_category 
FROM `case_study`.`default`.`bright_coffee_shop`;

--9. Checking product detal - 80 different product categories
SELECT DISTINCT product_detail
FROM `case_study`.`default`.`bright_coffee_shop`;

--10. Checking product type - 29 different product type
SELECT DISTINCT product_type
FROM `case_study`.`default`.`bright_coffee_shop`;

-- 11.Checking for Nulls in various colums - No Nulls
SELECT*
FROM `case_study`.`default`.`bright_coffee_shop`
WHERE unit_price IS NULL
OR transaction_date IS NULL;

--12. Checking lowest and highest unit price
SELECT
     MIN(unit_price) AS Lowest_unit_price,
     MAX(unit_price) AS Highest_unit_price
FROM `case_study`.`default`.`bright_coffee_shop`;

---13. Extracting the day name and monthnames
SELECT 
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name
FROM `case_study`.`default`.`bright_coffee_shop`;

--14. Calcualting the revenue
SELECT unit_price,
       transaction_qty,
       unit_price*transaction_qty AS Revenue
FROM `case_study`.`default`.`bright_coffee_shop`;

---Combining functions to get a clean and enhanced data set
SELECT 
      transaction_id,
      transaction_date,
      transaction_time,
      transaction_qty,
      store_id,
      store_location,
      product_id,
      unit_price,
      product_category,
      product_type,
      product_detail,
---Adding columns to enhance the table for better insights
---New column added 1
      Dayname(transaction_date) AS Day_name,
---New column added 2
      Monthname(transaction_Date) AS Month_name,
---New column added 3
      Dayofmonth(transaction_date) AS Date_of_month,
---New column added 4 - Determing weekday/ weekend
  CASE
      WHEN Dayname(transaction_date) IN ('Sunday', 'Saturday') THEN 'Weekend'
      ELSE 'Weekday'
  END AS Day_classification,
---New column added 5 - Time buckets
 
CASE
      WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '05:00:00'AND '08:59:59' THEN '01.Rush Hour'
      WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '09:00:00'AND '11:59:59' THEN '02.Mid morning'
      WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00'AND '15:59:59' THEN '03.Afternoon'
      WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '16:00:00'AND '18:00:00' THEN '01.Rush Hour'
      ELSE '05.Night'
  END AS Time_classification,

---New column added 6 - Spend buckets
 
CASE
      WHEN(transaction_qty*unit_price) <=50 THEN '01.Low spender'
      WHEN(transaction_qty*unit_price) BETWEEN 51 AND 200 THEN '02.Medium Spender'
      WHEN(transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '03.Moreki' 
      ELSE '04.Blesser'
  END AS Spend_bucket,

  --New column added 7 - Revenue
  transaction_qty*unit_price AS Revenue
FROM `case_study`.`default`.`bright_coffee_shop`;
