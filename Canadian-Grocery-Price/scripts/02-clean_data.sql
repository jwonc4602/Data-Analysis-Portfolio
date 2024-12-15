-- Preamble
-- Purpose: Cleans the raw grocery data
-- Author: Jiwon Choi
-- Date: 16 November 2024 
-- Contact: jwon.choi@mail.utoronto.ca
-- License: MIT
-- Pre-requisites: Get the SQL dataset from here: https://jacobfilipp.com/hammer/
-- open it with “Open Database” and navigate to where you downloaded the database.
-- Then open “Execute SQL”, and then type the following code, and click “Execute”.
-- Any other information needed: download DB Browser for SQLite (DB4S) -- https://sqlitebrowser.org/

DELETE FROM product
WHERE vendor IS NULL
   OR product_name IS NULL
   OR units IS NULL
   OR brand IS NULL
   OR sku IS NULL;

DELETE FROM raw
WHERE nowtime IS NULL
   OR current_price IS NULL
   OR old_price IS NULL
   OR price_per_unit IS NULL
   OR product_id IS NULL;

-- Check if any rows with null values remain in the product table
SELECT * FROM product
WHERE vendor IS NULL
   OR product_name IS NULL
   OR units IS NULL
   OR brand IS NULL
   OR sku IS NULL;

-- Check if any rows with null values remain in the raw table
SELECT * FROM raw
WHERE nowtime IS NULL
   OR current_price IS NULL
   OR old_price IS NULL
   OR price_per_unit IS NULL
   OR product_id IS NULL;
   
-- Remove duplicate rows in the product table based on unique product attributes
DELETE FROM product
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM product
    GROUP BY concatted
);

-- Remove duplicate rows in the raw table based on product_id and nowtime
DELETE FROM raw
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM raw
    GROUP BY product_id, nowtime
);

-- Drop the table if it already exists to avoid conflicts
DROP TABLE IF EXISTS combined_data;

-- Create a new table to store the joined data
CREATE TABLE combined_data AS
SELECT 
    r.nowtime,
    r.current_price,
    r.old_price,
    r.price_per_unit,
    p.vendor,
    p.product_name,
    p.units,
    r.product_id
FROM raw r
INNER JOIN product p ON r.product_id = p.id;

SELECT * FROM combined_data LIMIT 10;
