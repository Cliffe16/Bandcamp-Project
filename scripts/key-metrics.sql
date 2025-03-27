-- Generate a Report that shows all key metrics of the business
SELECT 'Total Revenue' AS measure_name, ROUND(SUM(amount_paid_usd), 2) AS measure_value FROM bandcamp_data
UNION ALL
SELECT 'Total Sales', COUNT(*) FROM bandcamp_data
UNION ALL
SELECT 'Total Tip', ROUND(SUM(amount_over_usd), 2) FROM bandcamp_data 
UNION ALL
SELECT 'Average Price', ROUND(AVG(item_price_usd), 2) FROM bandcamp_data
UNION ALL
SELECT 'Average Revenue', ROUND(AVG(amount_paid_usd), 2) FROM bandcamp_data
UNION ALL
SELECT 'Average Tip', ROUND(AVG(amount_over_usd), 2) FROM bandcamp_data 
UNION ALL
SELECT 'Total Albums Sold', COUNT(*) AS total_albums_sold FROM bandcamp_data WHERE item_type LIKE 'Albums'
UNION ALL
SELECT 'Total Tracks Sold', COUNT(*) AS total_tracks_sold FROM bandcamp_data WHERE item_type LIKE 'Tracks'
UNION ALL
SELECT 'Total Merchandise Sold', COUNT(*) AS total_merch_sold FROM bandcamp_data WHERE item_type LIKE 'Merchandise'
UNION ALL
SELECT 'Digital Media Sold', COUNT(*) AS total_digital_sold FROM bandcamp_data WHERE song_medium LIKE 'Digital%'
UNION ALL
SELECT 'Physical Media Sold', COUNT(*) AS total_physical_sold FROM bandcamp_data WHERE song_medium LIKE 'Physical%'
UNION ALL
SELECT 'Additional Music', SUM(addl_music) FROM bandcamp_data;