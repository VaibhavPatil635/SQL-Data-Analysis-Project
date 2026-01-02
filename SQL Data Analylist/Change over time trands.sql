SELECT COUNT(*) FROM retail_clean;
SELECT * FROM retail_clean;

-- Change Over Time(Trends)
SELECT 
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
ROUND(sum(total_order_value),0) AS total_sales,
COUNT(DISTINCT customer_id) as total_customers
FROM retail_clean
GROUP BY order_year,order_month
ORDER BY order_year,order_month
;