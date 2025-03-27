-- Determine the first and last sale date and the total duration in months
SELECT 
    MIN(sale_date) AS first_sale_date,
    MAX(sale_date) AS last_sale_date,
    DATEDIFF(MONTH, MIN(sale_date), MAX(sale_date)) AS sale_range_months
FROM bandcamp_data;