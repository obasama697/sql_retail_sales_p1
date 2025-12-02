## SQL Retail Sales Analysis - P1


-- View table
SELECT * FROM `sql - retail sales analysis_utf`;

-- Change column name
ALTER TABLE `sql - retail sales analysis_utf`
CHANGE COLUMN `ï»¿transactions_id` transactions_id INT;

-- Change Table name
ALTER TABLE `sql - retail sales analysis_utf` RENAME TO retail_sales;

-- View table name
SHOW TABLES;

### Exploratory Data Analysis(EDA)

SELECT * FROM retail_sales
LIMIT 10;

SELECT COUNT(*) FROM retail_sales;

-- Data cleaning [Null Vales]

SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE 
		transactions_id IS NULL
        OR
        sale_date IS NULL
        OR
        sale_time IS NULL
        OR
        gender IS NULL
        OR
        category IS NULL
        OR
        price_per_unit IS NULL
        OR
        cogs IS NULL
        OR
        total_sale IS NULL
        OR
        quantiy IS NULL;

-- Data Exploration [COUNT, DISTINCT Function]

-- 1. How many sales we have?
SELECT COUNT(*) as total_sales FROM retail_sales;

-- 2. How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- 3. How many uniue catgory we have?
SELECT COUNT(DISTINCT category) FROM retail_sales;

### Key Business Problems & Analysis

-- Q1. Retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q2. Retrieve all transactions where the category is 'Clothing' and the quantity sold is equal or more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND quantiy >= 4
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
    
-- Q3. Calculate the total sales and total orders for each category
SELECT
	category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

-- Q4. Find the average age of customers who purchased items from the 'Beauty' category;
SELECT 
	ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
    
-- Q5. Find all transactions where the total_sale is greater than 1000;
SELECT * FROM retail_sales
WHERE total_sale >= 1000;
	
-- Q6. Find the total number of transactions (transaction_id) made by each gender in each category;
SELECT
	category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

-- Q7. Calculate the average sale for each month. Find the best-selling month in each year;
SELECT * FROM
(
	SELECT
		YEAR(sale_date) As year,
		MONTH(sale_date) As month,
		ROUND(AVG(total_sale), 2) as avg_sale,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rnk = 1;
    
-- Q8. Find the top 5 customers based on the highest total sales;
SELECT 
	customer_id,
    SUM(total_sale)
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC LIMIT 5;

-- Q9. Find the number of unique customers who purchased items from each category;
SELECT 
	category,
    COUNT(DISTINCT customer_id) as count_unique_customer
FROM retail_sales
GROUP BY 1;

-- Q10. Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17);
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT 
	shift,
    COUNT(*) as total_orders 
FROM hourly_sale
GROUP BY shift;

### END OF PROJECT