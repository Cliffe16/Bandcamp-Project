-- Which item type contributes the most to overall sales and by what percentage?
WITH item_type_sales AS (
    SELECT
        item_type,
        ROUND(SUM(amount_paid_usd), 2) AS total_revenue
    FROM bandcamp_data
    GROUP BY item_type
)
SELECT
    item_type,
    total_revenue,
    SUM(total_revenue) OVER () AS overall_sales,
    ROUND((CAST(total_revenue AS FLOAT) / SUM(total_revenue) OVER ()) * 100, 2) AS percentage_of_total
FROM item_type_sales
ORDER BY total_revenue DESC;

-- Which country contributes the most to overall sales?

WITH country_sales AS (
    SELECT
        country,
        ROUND(SUM(amount_paid_usd), 2) AS total_revenue
    FROM bandcamp_data
    GROUP BY country
)
SELECT TOP(5)
    country,
    total_revenue,
    SUM(total_revenue) OVER () AS overall_sales,
    ROUND((CAST(total_revenue AS FLOAT) / SUM(total_revenue) OVER ()) * 100, 2) AS percentage_of_total
FROM country_sales
ORDER BY total_revenue DESC;

-- Which American artist contributes the most to overall sales and by what percentage?
WITH artist_sales AS (
    SELECT
        artist_name,
		country,
        ROUND(SUM(amount_paid_usd), 2) AS total_revenue
    FROM bandcamp_data
    GROUP BY artist_name, country
)
SELECT TOP(5)
    artist_name,
    total_revenue,
    SUM(total_revenue) OVER () AS overall_sales,
    ROUND((CAST(total_revenue AS FLOAT) / SUM(total_revenue) OVER ()) * 100, 2) AS percentage_of_total
FROM artist_sales
WHERE country = 'United States' AND /*to get the artist name*/ artist_name NOT LIKE '%Artist%'
ORDER BY total_revenue DESC;
