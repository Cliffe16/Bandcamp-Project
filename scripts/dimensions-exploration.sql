-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
    country 
FROM bandcamp_data
ORDER BY country;

-- Retrieve a list of unique item_types and media
SELECT DISTINCT 
    item_type, 
    song_medium 
FROM bandcamp_data
ORDER BY item_type, song_medium;

-- Retrieve a list of unique artists 
SELECT DISTINCT 
    artist_name 
FROM bandcamp_data
WHERE artist_name IS NOT NULL
ORDER BY artist_name;