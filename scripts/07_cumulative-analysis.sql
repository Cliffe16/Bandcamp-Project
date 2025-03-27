-- Calculate the total sales per week and the running total of sales over time 
SELECT
	sale_date,
	total_revenue,
	SUM(total_revenue) OVER (ORDER BY sale_date) AS running_total_revenue,
	AVG(avg_price) OVER (ORDER BY sale_date) AS moving_average_price
FROM
(
    SELECT 
        DATETRUNC(WEEK, sale_date) AS sale_date,
        ROUND(SUM(amount_paid_usd), 2) AS total_revenue,
        ROUND(AVG(item_price_usd), 2) AS avg_price
    FROM bandcamp_data
    WHERE sale_date IS NOT NULL
    GROUP BY DATETRUNC(WEEK, sale_date)
) t
