--Group artists by generosity of their fans(based on how much extra money was paid
	--on a sale)
WITH generosity_index AS (
    SELECT
        artist_name,
        id,
        amount_over_usd,
        CASE 
            WHEN amount_over_usd BETWEEN 0 AND 50 THEN 'Regular'
            WHEN amount_over_usd BETWEEN 50 AND 100 THEN 'VIP'
            ELSE 'Die Hard'
        END AS customer_type
    FROM bandcamp_data
)
SELECT
	artist_name,
    customer_type,
    COUNT(id) AS total_sales
FROM generosity_index
GROUP BY artist_name, customer_type 
HAVING customer_type = 'Die Hard'
ORDER BY total_sales DESC;

--Group albums by generosity of their fans(based on how much extra money was paid
	--on a sale)
WITH generosity_index AS (
    SELECT
		artist_name,
        album_title,
        id,
        amount_over_usd,
        CASE 
            WHEN amount_over_usd BETWEEN 0 AND 50 THEN 'Regular'
            WHEN amount_over_usd BETWEEN 50 AND 100 THEN 'VIP'
            ELSE 'Die Hard'
        END AS customer_type
    FROM bandcamp_data
)
SELECT
	artist_name,
	album_title,
    customer_type,
    COUNT(id) AS total_sales
FROM generosity_index
WHERE album_title != ' ' --assuming records without the album title are not albums
GROUP BY album_title, customer_type, artist_name
	HAVING album_title IS NOT NULL AND customer_type = 'Die Hard'
ORDER BY total_sales DESC;

--Group country by generosity of their fans(based on how much extra money was paid
	--on a sale)
WITH generosity_index AS (
    SELECT
        country,
        id,
        amount_over_usd,
        CASE 
            WHEN amount_over_usd BETWEEN 0 AND 50 THEN 'Regular'
            WHEN amount_over_usd BETWEEN 50 AND 100 THEN 'VIP'
            ELSE 'Die Hard'
        END AS customer_type
    FROM bandcamp_data
)
SELECT
	country,
    customer_type,
    COUNT(id) AS total_sales
FROM generosity_index
GROUP BY country, customer_type
HAVING customer_type = 'Die Hard'
ORDER BY total_sales DESC;
