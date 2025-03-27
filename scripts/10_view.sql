-- Create Report: bandcamp_sales
IF OBJECT_ID('bandcamp_sales', 'V') IS NOT NULL
    DROP VIEW bandcamp_sales;
GO

CREATE VIEW bandcamp_sales AS

WITH base_query AS (
/*
1) Base Query: Retrieves core columns from tables
*/
SELECT
	id,
	art_url,
	song_medium,
	item_type,
	album_title,
	track_title,
	artist_name,
	country,
	releases,
	addl_music,
	item_price_usd,
	amount_paid_usd,
	sale_date,
	amount_over_usd
FROM bandcamp_data 
WHERE sale_date IS NOT NULL

), sales_aggregation AS (
/*
2) Sales Aggregations: Summarizes key metrics of the sales
*/
SELECT 
	id,
	song_medium,
	item_type,
	album_title,
	track_title,
	artist_name,
	country,
	item_price_usd AS item_price,
	amount_paid_usd AS amount_paid,
	sale_date,
	amount_over_usd AS amount_over,
	COUNT(id) AS total_orders,
	(SELECT COUNT(*) AS total_merch_sold FROM base_query WHERE item_type LIKE 'Merchandise') AS
		total_merch_sold,
	(SELECT COUNT(*) FROM base_query WHERE song_medium LIKE 'Digital%') AS
		total_digital_sold,
	(SELECT COUNT(*) FROM base_query WHERE song_medium LIKE 'Physical%') AS
		total_physical_sold,
	ROUND(SUM(amount_paid_usd), 2) AS total_revenue,
	ROUND(SUM(amount_over_usd), 2) AS total_tips,
	SUM(addl_music) AS total_addl_music,
	ROUND(AVG(amount_paid_usd), 2) AS avg_revenue,
	MAX(sale_date) AS last_sale_date,
	DATEDIFF(MONTH, MIN(sale_date), MAX(sale_date)) AS sale_range_months
FROM base_query
GROUP BY 
	id,
	song_medium,
	item_type,
	album_title,
	track_title,
	artist_name,
	country,
	item_price_usd,
	amount_paid_usd,
	sale_date,
	amount_over_usd
)
SELECT
	song_medium,
	item_type,
	album_title,
	track_title,
	artist_name,
	country,
	CASE
		WHEN amount_over BETWEEN 0 AND 50 THEN 'Regular'
		WHEN amount_over BETWEEN 50 AND 100 THEN 'VIP'
		ELSE 'Die Hard'
	END AS customer_type,
	last_sale_date,
	total_orders,
	total_revenue,
	total_tips,
	total_addl_music,
	total_merch_sold,
	total_digital_sold,
	total_physical_sold,
-- Computate average order value 
	CASE WHEN total_revenue = 0 THEN 0
		 ELSE total_revenue / total_orders
	END AS avg_order_value,
-- Compuate average monthly spend
	CASE WHEN sale_range_months = 0 THEN total_revenue
	     ELSE total_revenue / sale_range_months
	END AS avg_monthly_spend
FROM sales_aggregation;
