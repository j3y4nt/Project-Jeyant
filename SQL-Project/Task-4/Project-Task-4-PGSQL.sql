------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

-- Task 4 - Project: OLAP Operations (using PostgreSQL)

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

-- 1. Database Creation

CREATE DATABASE sales_database;

CREATE TABLE sales_sample (
Product_Id INTEGER,
Region VARCHAR(50),
"Date" DATE,
Sales_Amount INTEGER
)

------------------------------------------------------------------------------------------------------------------------------------

-- 2. Data Creation

INSERT INTO sales_sample (Product_Id, Region, "Date", Sales_Amount)
VALUES
(1001, 'East', '2024-01-01',1000),
(1002, 'West', '2024-01-13',1500),
(1001, 'East', '2024-01-16',2000),
(1003, 'North', '2024-01-22',1800),
(1004, 'South', '2024-01-29',1500),
(1002, 'West', '2024-02-01',1500),
(1001, 'North', '2024-02-03',1300),
(1003, 'South', '2024-02-08',2000),
(1004, 'West', '2024-02-11',2100),
(1005, 'South', '2024-02-14',1200)


------------------------------------------------------------------------------------------------------------------------------------

/* 
3. Perform OLAP operations 
*/

-- a) Drill Down-Analyze sales data at a more detailed level. Write a query to perform drill down from region to product level to understand sales performance.

SELECT Region, Product_Id, SUM(Sales_Amount) As Total_Sales
FROM sales_sample
GROUP BY Region, Product_Id
ORDER BY Region, Product_Id


------------------------------------------------------------------------------------------------------------------------------------

-- b) Rollup- To summarize sales data at different levels of granularity. Write a query to perform roll up from product to region level to view total sales by region.

SELECT COALESCE(Region, 'Grand Total') AS Region, COALESCE(CAST(Product_Id AS VARCHAR), 'All products') AS Product_Id,
SUM(Sales_Amount) AS Total_Sales, COUNT(*) AS Transaction_Count, ROUND(AVG(Sales_Amount),0) AS Avg_Sales_Per_Transaction
FROM sales_sample
GROUP BY ROLLUP(Region, Product_Id)
ORDER BY Product_Id;


------------------------------------------------------------------------------------------------------------------------------------

-- c) Cube - To analyze sales data from multiple dimensions simultaneously. Write a query to Explore sales data from different perspectives, such as product, region, and date


SELECT COALESCE(CAST(Product_Id AS VARCHAR), 'All products') AS Product_Id, COALESCE(Region, 'All regions') AS Region,
COALESCE(TO_CHAR("Date", 'YYYY-MM'), 'All months') AS "Month", SUM(Sales_Amount) AS Total_Sales, COUNT(*) AS Transaction_Count,
ROUND(AVG(Sales_Amount),0) AS Avg_Sales
FROM sales_sample
GROUP BY CUBE(Product_Id, Region, TO_CHAR("Date", 'YYYY-MM'))
ORDER BY Product_Id, Region, "Month";


------------------------------------------------------------------------------------------------------------------------------------

-- d) Slice- To extract a subset of data based on specific criteria. Write a query to slice the data to view sales for a particular region or date range.

-- region
SELECT * FROM sales_sample
WHERE Region = 'South'
ORDER BY Product_Id, "Date"

-- date range
SELECT * FROM sales_sample
WHERE "Date" BETWEEN '2024-02-01' AND '2024-02-28'
ORDER BY Region, Product_Id, "Date"


------------------------------------------------------------------------------------------------------------------------------------

-- e) Dice - To extract data based on multiple criteria. Write a query to view sales for specific combinations of product, region, and date

SELECT * FROM sales_sample
WHERE Region IN ('East','North') AND
Product_Id IN (1001,1003) AND
"Date" BETWEEN '2024-01-01' AND '2024-01-31'


------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------



