/* Segment products into cost ranges and count
 how many products fail into each segmant */
WITH product_segment as(
SELECT 
product_name,
product_id,
discount_price,
CASE WHEN discount_price < 100 THEN 'Below 100'
	 WHEN discount_price BETWEEN 100 AND 500 THEN '100-500'
     WHEN discount_price BETWEEN 500 AND 1000 THEN '500-1000'
     ELSE 'Above 1000'
END cost_range
FROM retail_clean
)
SELECT 
cost_range,
COUNT(product_id) as total_products
FROM product_segment
GROUP BY cost_range
ORDER BY total_products desc;


/* Group customers into three segment based on their spending behavior:
	- VIP: at least 12 month of history and spending more then 2000.
    -Regular: at least 12 month of histroy but spending 2000 or less.
    -New: lifespan less then 12 month. 
And find the total number of customer by each group */
WITH customer_spending as(
SELECT
customer_id,
SUM(total_order_value) as total_spending,
MIN(order_date) as first_order,
MAX(order_date) as last_order,
TIMESTAMPDIFF(
        MONTH,
        MIN(Order_Date),
        MAX(Order_Date)
    ) AS lifespan_months
FROM retail_clean
GROUP BY Customer_ID
)

SELECT
customer_segement,
COUNT(customer_id) as total_customers 
FROM (
	SELECT
	customer_id,
	CASE WHEN lifespan_months >= 12 AND total_spending > 2000 THEN 'VIP'
		 WHEN lifespan_months >= 12 AND total_spending <= 2000 THEN 'Regular'
		 ELSE 'New'
	END customer_segement
	FROM customer_spending
)t
GROUP BY customer_segement
ORDER BY total_customers desc