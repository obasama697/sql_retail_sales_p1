# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis – SQL 
**Level**: Beginner to Intermediate  
**Database**: `retail_sales`

This project demonstrates practical SQL skills that data analysts use to explore, clean, and analyze real-world retail sales data. The project covers complete SQL workflow—starting from renaming tables and cleaning corrupted columns to performing exploratory data analysis (EDA) and solving business-driven queries.  

It is ideal for anyone looking to strengthen their SQL fundamentals and showcase analytical problem-solving with real business use cases.

---

## Objectives

1. **Set Up & Clean the Dataset**:  
   Correct column names, rename table, and prepare the dataset for analysis.

2. **Data Quality Checks**:  
   Identify null values and understand the structure of the dataset.

3. **Exploratory Data Analysis (EDA)**:  
   Explore the dataset—count customers, categories, transactions, etc.

4. **Business Insights & SQL Analysis**:  
   Answer 10+ business questions using SQL queries such as sales trends, top customers, category performance, and shift-wise demand.

---

## Project Structure

### 1. Database & Table Setup

The dataset is imported from a CSV file and then cleaned using SQL.  
Key steps include:

- Renaming corrupted column:  
  `ï»¿transactions_id` → `transactions_id`
- Renaming the table:  
  `sql - retail sales analysis_utf` → `retail_sales`

```sql
-- View initial table
SELECT * FROM `sql - retail sales analysis_utf`;

-- Fix corrupted column name
ALTER TABLE `sql - retail sales analysis_utf`
CHANGE COLUMN `ï»¿transactions_id` transactions_id INT;

-- Rename table
ALTER TABLE `sql - retail sales analysis_utf`
RENAME TO retail_sales;

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT *
FROM retail_sales
WHERE 
      transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL
   OR quantiy IS NULL;
```

### 3. Data Analysis & Business Questions

The following SQL queries were developed to answer specific business questions:

1. **Retrieve all columns for sales made on 2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND quantiy >= 4
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
```

3. **Calculate total sales & total orders for each category.**:
```sql
SELECT
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;
```

4. **Find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

5. **Find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

6. **Find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;
```

7. **Calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT *
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale,
        RANK() OVER(PARTITION BY YEAR(sale_date)
                     ORDER BY AVG(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY 1, 2
) AS t1
WHERE rnk = 1;
```

8. **Find the top 5 customers based on the highest total sales**:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

9. **Find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS count_unique_customer
FROM retail_sales
GROUP BY 1;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This SQL project provides a complete overview of analyzing retail sales data—from data cleaning to insightful business analysis.
It showcases core SQL skills needed by data analysts and provides a strong foundation for more advanced analytics projects.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Import Dataset**: Upload CSV into your SQL environment.
3. **Run the Queries**: Execute the included SQL file to clean and analyze the data.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.



### Stay Updated and connected


- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/rupal--tripathi/)


Thank you for your support, and I look forward to connecting with you!

