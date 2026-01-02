/* Analyze the yearly perfomance of product by comparing each product sales 
to both its average sales performance and the priveous years sales */
WITH yearly_category_sales AS(
SELECT 
YEAR(order_date) AS yearly_performance,
Product_Name,
ROUND(SUM(total_order_value),0) AS current_sales
FROM
retail_clean
GROUP BY Product_Name, Year(Order_Date)
ORDER BY yearly_performance 
)
SELECT
product_name,
yearly_performance,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) as avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) as diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
     WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
     ELSE 'Avg'
 END avg_change,
 -- Year-over-year-analysis
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY yearly_performance) AS py_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY yearly_performance) AS diff_py,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY yearly_performance) > 0 THEN 'Increace'
	 WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY yearly_performance) < 0 THEN 'Decreace'
     ELSE 'No change'
END py_change
FROM yearly_category_sales 

