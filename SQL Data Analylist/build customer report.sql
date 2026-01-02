/*
================================================================================================================================
Customer Report
=================================================================================================================================
Purpose:
	-This report consolidates key customer metrics and behaviors
    
Highlights:
	1. Gathers essential fields such as names, ages and transaction details.
    2. Segment customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer_level metrics:
		- total orders
        - total sales
        - total products
        - lifespan (in months)alter
	4. Calculates valuable KPI:
		- recency (month since last order)
        - average order values
        - average monthly spend
=====================================================================================================================================
*/

/* ----------------------------------------------------------------------
Base Query: Retrieves core columns from tables
-------------------------------------------------------------------------*/
CREATE VIEW dmart_customers as
WITH base_query as(

SELECT
bill_number,
product_id,
order_date,
Order_ID,
total_order_value,
customer_id,
customer_age,
gender,
state,
city
FROM retail_clean)
,customer_aggregation as(
SELECT
	customer_id,
	customer_age,
	gender,
	state,
	city,
	COUNT(customer_id) as total_orders,
	SUM(total_order_value) as total_sales,
	MAX(order_date) as last_order_date,
	TIMESTAMPDIFF(
			MONTH,
			MIN(Order_Date),
			MAX(Order_Date)
		) AS lifespan_months
FROM base_query
GROUP BY
	customer_id,
	customer_age,
	gender,
	state,
    city
)

SELECT 
	customer_id,
	customer_age,
	gender,
	state,
	city,
	CASE WHEN customer_age < 20 THEN 'UNDER 20'
		 WHEN customer_age between 20 AND 29 THEN '20-29'
         WHEN customer_age between 30 AND 39 THEN '30-39'
         WHEN customer_age between 40 AND 49 THEN '40-49'
         ELSE '50 and above'
    END as Age_group,     
    CASE WHEN lifespan_months >= 12 or total_sales > 2000 THEN 'VIP'
		 WHEN lifespan_months >= 12 or total_sales <= 2000 THEN 'Regular'
		 ELSE 'New'
	END customer_segement,
    last_order_date,
    TIMESTAMPDIFF(
			MONTH,
			last_order_date,
			CURDATE()
		) AS recency,
	total_orders,
	total_sales,
	lifespan_months,
    -- compute average order value (AVO)
    total_sales / total_orders as avg_order_value
    FROM customer_aggregation
    