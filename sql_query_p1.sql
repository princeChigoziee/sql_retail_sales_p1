-- SQL Retail Sales Analysis - p1

CREATE DATABASE sql_project_p2;
USE sql_project_p2;

-- Create Table
CREATE TABLE retail_sales
(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,	
		customer_id	INT,
        gender VARCHAR(50),
		age	INT,
        category VARCHAR(50),
		quantiy	INT,
        price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
);

SELECT 
	*
FROM retail_sales;

SELECT
	COUNT(*)
FROM retail_sales;

-- DATA CLEANING
ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;

SELECT *
FROM retail_sales
WHERE
	transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR 
    total_sale;

-- DATA EXPLORATION
-- How many SALES we have?
SELECT 
	COUNT(*) AS total_sales
FROM retail_sales;

-- How many unique CUSTOMER we have?

SELECT
	COUNT(DISTINCT customer_id) AS total_customer
FROM retail_sales;

SELECT DISTINCT category
FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers
-- Write a SQL query to retrieve all columns for sales made on '22-11-05'

SELECT *
FROM retail_sales
WHERE sale_date = '22-11-05';

-- Write a SQL query to calculate the total sales (total_sale) for each category

SELECT category, SUM(total_sale) AS net_sale,
COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Write a SQL query to find the average age of customer who purchased items from the 'Beauty' category

SELECT category, 
ROUND(AVG(age), 2) AS avg_age, 
COUNT(*) AS total_beauty_product
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;

-- Write a SQL query to find all transaction where the total_sale is greater than 1000

	SELECT *
    FROM retail_sales
    WHERE total_sale > 1000;
    
-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT gender, category,
COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY
	gender, category
ORDER BY category;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
	year,
	month,
	avg_sale
FROM 
(
	SELECT 
		YEAR(sale_date) AS 'year',
		MONTH(sale_date) AS 'month',
		ROUND(AVG(total_sale), 2) AS avg_sale,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranking
	FROM retail_sales
	GROUP BY Year, Month
) AS table_1
WHERE ranking = 1;

-- Write a SQL query to find the top 5 customers based on the highest total sales

SELECT customer_id,
SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category;

SELECT 
	category,
    COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sales
GROUP BY category;