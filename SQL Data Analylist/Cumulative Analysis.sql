/*Calulate the total sales per year and the running
 total of sales overtime */
 
SELECT 
yearwise_order_date,
total_sales,
SUM(total_sales) OVER (ORDER BY yearwise_Order_Date) as running_total_sales,
AVG(avg_price) OVER (ORDER BY yearwise_Order_Date) as moving_average_sales
FROM
(
	SELECT 
	YEAR(order_date) as yearwise_order_date,
	ROUND(SUM(total_order_value),0) as total_sales,
    ROUND(AVG(MRP),2) as avg_price
	FROM retail_clean
	GROUP BY YEAR (Order_Date)
	
)t
ORDER BY yearwise_order_date;