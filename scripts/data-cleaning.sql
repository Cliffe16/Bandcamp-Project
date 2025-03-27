--Remove the url from the id column
GO
CREATE FUNCTION [dbo].[udfGetCharacters](@inputString VARCHAR(MAX), @validChars VARCHAR(100))  
	RETURNS VARCHAR(500) AS 
BEGIN 

	WHILE @inputString like '%[^' + @validChars + ']%' 
		SELECT @inputString = REPLACE(@inputString,SUBSTRING(@inputString,PATINDEX('%[^' + @validChars + ']%',@inputString),1),' ')  
			SELECT @inputString = (SELECT LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@inputString,'  ',' ||*9*9||'),'||*9*9|| ',''),'||*9*9||','')
			)))
    RETURN @inputString  
	     
END;
GO
UPDATE bandcamp_data
SET id = Bandcamp_Sales.dbo.udfGetCharacters(id, '0-9')
WHERE id != Bandcamp_Sales.dbo.udfGetCharacters(id, '0-9');
--Remove whitespace between the numbers
UPDATE bandcamp_data
SET id = REPLACE(id, ' ', '');

--Removing Special Characters From column amount_over_fmt
BEGIN TRAN
UPDATE bandcamp_data
SET amount_over_fmt = LTRIM(amount_over_fmt,'â''Â''¬''£''¥''‚');
--Remove whitespace between the numbers
UPDATE bandcamp_data
SET amount_over_fmt = REPLACE(amount_over_fmt, ' ', '');

COMMIT;

--Rename item types
UPDATE bandcamp_data
SET item_type = CASE 
					WHEN item_type = 'a' THEN 'Digital Albums'
					WHEN item_type = 'b' THEN 'Physical Items'
				ELSE 'Digital Tracks'
				END;

--Rename slug types
UPDATE bandcamp_data
SET slug_type = CASE 
					WHEN slug_type = 'a' THEN 'Albums'
					WHEN slug_type = 'p' THEN 'Merchandise'
				ELSE 'Tracks'
				END;

--Convert the date format
BEGIN TRAN
ALTER TABLE bandcamp_data
ADD converted_date DATE;

UPDATE bandcamp_data
SET converted_date = DATEADD(SECOND, utc_date, '1970-01-01');

COMMIT;
--Standardize the currency
ALTER TABLE bandcamp_data
ADD item_price_usd FLOAT

UPDATE bandcamp_data
SET item_price_usd = ROUND(item_price * (amount_paid_usd/amount_paid), 2);
--Standardizing column amount_over_fmt
ALTER TABLE bandcamp_data
ADD amount_over_usd FLOAT;

UPDATE bandcamp_data
SET amount_over_usd = (amount_paid_usd - item_price_usd);

--Cleaning artist_name column
UPDATE bandcamp_data
SET artist_name = CASE WHEN artist_name = ' ' THEN 'Unknown Artist'
					   ELSE artist_name
				  END

--Cleaning album_title column
UPDATE bandcamp_data
SET album_title = CASE WHEN album_title = ' ' THEN NULL
					   ELSE album_title
				  END

--Cleaning track_album_slug_text column
UPDATE bandcamp_data
SET track_album_slug_text = CASE WHEN track_album_slug_text = ' ' THEN NULL
								 ELSE track_album_slug_text
							END

--Remove unnecessary columns
BEGIN TRAN

ALTER TABLE bandcamp_data
DROP COLUMN country_code,--country column exists
			amount_paid_fmt, --duplicate column
			item_description, --irrelevant
			art_id,
			package_image_id,
			utc_date,
			item_slug, --duplicate
			url,
			item_price, -- standardized
			amount_over_fmt,
			currency --irrelevant
		
COMMIT; 

--Renaming columns
GO
EXEC sp_rename N'dbo.bandcamp_data.track_album_slug_text', N'track_title', 'COLUMN'
GO
EXEC sp_rename N'dbo.bandcamp_data._id', N'id', 'COLUMN'
GO
EXEC sp_rename N'dbo.bandcamp_data.addl_count', N'addl_music', 'COLUMN'
GO
EXEC sp_rename N'dbo.bandcamp_data.item_type', N'song_medium', 'COLUMN'
GO
EXEC sp_rename N'dbo.bandcamp_data.slug_type', N'item_type', 'COLUMN'
GO
EXEC sp_rename N'dbo.bandcamp_data.converted_date', N'sale_date', 'COLUMN'
GO