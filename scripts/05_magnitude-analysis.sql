-- Find total sales per country
SELECT
    TOP(15)country,
    COUNT(*) AS total_sales
FROM bandcamp_data
GROUP BY country
ORDER BY total_sales DESC;

-- Find average price per country
SELECT
    TOP(15)country,
    ROUND(AVG(item_price_usd), 2) AS avg_price
FROM bandcamp_data
GROUP BY country
ORDER BY avg_price DESC;

-- Find total revenue per country
SELECT
    TOP(15)country,
    ROUND(SUM(amount_paid_usd), 2) AS total_revenue
FROM bandcamp_data
GROUP BY country
ORDER BY total_revenue DESC;

-- Find total tips per country
SELECT
    TOP(15)country,
    ROUND(SUM(amount_over_usd), 2) AS total_tips
FROM bandcamp_data
GROUP BY country
ORDER BY total_tips DESC;

-- Find additional music per country
SELECT
    TOP(15)country,
    COUNT(addl_music) AS addl_music
FROM bandcamp_data
GROUP BY country
ORDER BY addl_music DESC;

-- Find total sales per artist
SELECT
    TOP(15)artist_name,
    COUNT(*) AS total_sales
FROM bandcamp_data
GROUP BY artist_name
ORDER BY total_sales DESC;

-- Find average price per artist
SELECT
    TOP(15)artist_name,
    ROUND(AVG(item_price_usd), 2) AS avg_price
FROM bandcamp_data
GROUP BY artist_name
ORDER BY avg_price DESC;

-- Find total revenue per artist
SELECT
    TOP(15)artist_name,
    ROUND(SUM(amount_paid_usd), 2) AS total_revenue
FROM bandcamp_data
GROUP BY artist_name
ORDER BY total_revenue DESC;

-- Find total tips per artist
SELECT
    TOP(15)artist_name,
    ROUND(SUM(amount_over_usd), 2) AS total_tips
FROM bandcamp_data
GROUP BY artist_name
ORDER BY total_tips DESC;

-- Find additional music per artist
SELECT
    TOP(15)artist_name,
    COUNT(addl_music) AS addl_music
FROM bandcamp_data
GROUP BY artist_name
ORDER BY addl_music DESC;

--Check if extra pay is due to additional music
SELECT
    TOP(15)artist_name,
    COUNT(addl_music) AS addl_music,
	amount_over_usd
FROM bandcamp_data
GROUP BY artist_name, amount_over_usd
ORDER BY amount_over_usd DESC;

-- Find total sales per item_type
SELECT
    item_type,
    COUNT(*) AS total_sales
FROM bandcamp_data
GROUP BY item_type
ORDER BY total_sales DESC;

-- Find avergae price per item_type
SELECT
    item_type,
    ROUND(AVG(item_price_usd), 2) AS avg_price
FROM bandcamp_data
GROUP BY item_type
ORDER BY avg_price DESC;

-- Find total revenue per item_type
SELECT
    item_type,
    ROUND(SUM(amount_paid_usd), 2) AS total_revenue
FROM bandcamp_data
GROUP BY item_type
ORDER BY total_revenue DESC;

-- Find additional music per item_type
SELECT
    TOP(15)item_type,
    COUNT(addl_music) AS addl_music
FROM bandcamp_data
GROUP BY item_type
ORDER BY addl_music DESC;

-- Find total sales per medium
SELECT
    CASE WHEN song_medium = 'Digital Tracks' THEN 'Digital'
		 WHEN song_medium = 'Digital Albums' THEN 'Digital'
		 ELSE 'Physical'
	END AS media,
    COUNT(*) AS total_sales
FROM bandcamp_data
GROUP BY CASE WHEN song_medium = 'Digital Tracks' THEN 'Digital'
		 WHEN song_medium = 'Digital Albums' THEN 'Digital'
		 ELSE 'Physical'
	END 
ORDER BY total_sales DESC;

-- What is the average cost in each medium?
SELECT
    CASE WHEN song_medium = 'Digital Tracks' THEN 'Digital'
		 WHEN song_medium = 'Digital Albums' THEN 'Digital'
		 ELSE 'Physical'
	END AS media,
    ROUND(AVG(item_price_usd),2) AS avg_price
FROM bandcamp_data
GROUP BY CASE WHEN song_medium = 'Digital Tracks' THEN 'Digital'
		 WHEN song_medium = 'Digital Albums' THEN 'Digital'
		 ELSE 'Physical'
	END 
ORDER BY avg_price DESC;

-- What is the total revenue generated for each medium?
SELECT
    CASE WHEN song_medium = 'Digital Tracks' THEN 'Digital'
		 WHEN song_medium = 'Digital Albums' THEN 'Digital'
		 ELSE 'Physical'
	END AS media,
    ROUND(SUM(amount_paid_usd),2) AS total_revenue
FROM bandcamp_data
GROUP BY CASE WHEN song_medium = 'Digital Tracks' THEN 'Digital'
		 WHEN song_medium = 'Digital Albums' THEN 'Digital'
		 ELSE 'Physical'
	END 
ORDER BY total_revenue DESC;

-- Find additional music per medium
SELECT
    CASE WHEN song_medium = 'Digital Tracks' THEN 'Digital'
		 WHEN song_medium = 'Digital Albums' THEN 'Digital'
		 ELSE 'Physical'
	END AS media,
    COUNT(addl_music) AS addl_music
FROM bandcamp_data
GROUP BY CASE WHEN song_medium = 'Digital Tracks' THEN 'Digital'
		 WHEN song_medium = 'Digital Albums' THEN 'Digital'
		 ELSE 'Physical'
	END 
ORDER BY addl_music DESC;
