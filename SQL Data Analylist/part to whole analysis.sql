/* Which category contribute the most to overall sales */

WITH category_sales as(
SELECT 
category,
SUM(Total_Order_Value) as total_sales
FROM 
retail_clean
GROUP BY category
)
SELECT 
category,
total_sales,
SUM(total_sales) OVER() as overall_sales,
CONCAT(ROUND((total_sales / SUM(total_sales) OVER ()) * 100,2), '%') as percentage_of_total
FROM category_sales