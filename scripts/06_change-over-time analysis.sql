-- Analyse sales performance over time
SELECT
    DATETRUNC(WEEK, sale_date) AS sale_date,
    ROUND(SUM(amount_paid_usd), 2) AS total_revenue,
    COUNT(DISTINCT id) AS total_sales
FROM bandcamp_data
WHERE sale_date IS NOT NULL
GROUP BY DATETRUNC(WEEK, sale_date)
ORDER BY DATETRUNC(WEEK, sale_date);
