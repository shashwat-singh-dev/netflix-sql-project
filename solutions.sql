-- NETFLIX PROJECT

CREATE TABLE netflix
(
	show_id  VARCHAR(6),
	type  VARCHAR(10),
	title  VARCHAR(150),
	director  VARCHAR(208),
	casts  VARCHAR(1000),
	country  VARCHAR(150),
	date_added  VARCHAR(50),
	release_year  INT,
	rating   VARCHAR(10),
	duration VARCHAR(15)  ,
	listed_in  VARCHAR(100),
	description  VARCHAR(300)

);

SELECT * FROM netflix;

-- . Unique types of content (movies, tv shows)
SELECT DISTINCT type FROM  netflix;

--  -----------------------------------------------      15 BUSINESS PROBLEMS   ------------------------------------------

-- 1.  Count the no. of movies vs TV shows ( 6131, 2676 )
SELECT COUNT(*) 
FROM netflix
WHERE type = 'Movie';

SELECT COUNT(*) 
FROM netflix
WHERE type = 'TV Show';
-- Final main one
SELECT type, COUNT(*) as total_content
FROM netflix
GROUP BY type;

--2. Find the most common rating for movies and TV shows

SELECT DISTINCT ON (type)
       type,
       rating,
       COUNT(*) AS rating_count
FROM netflix
GROUP BY type, rating
ORDER BY type, rating_count DESC;


-- 3. List all movies released in year (2020)

SELECT *
from netflix
WHERE release_year = 2020
AND type = 'Movie';

-- 4. Find the top 5 countries with the most content on netlflix

SELECT
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS new_country,
    COUNT(show_id) AS total_content
FROM netflix
WHERE country IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 5. Identify the longest movie

SELECT title, type, duration
FROM netflix
WHERE type = 'Movie' AND duration IS NOT NULL
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) DESC
LIMIT 1;

-- 6. Find content added in the last 5 years

SELECT * 
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY' )  >= CURRENT_DATE - INTERVAL '5 years'

SELECT CURRENT_DATE - INTERVAL '5 years'

-- 7. Find all the movies/ TV shows directed by 'Rajiv Chilaka'

SELECT type, director
FROM netflix
WHERE director LIKE  '%Rajiv Chilaka%' ;


-- 8. List all TV shows with more than 5 seasons

SELECT type, duration
FROM netflix WHERE type = 'TV Show'
AND SPLIT_PART(duration,' ', 1):: integer > 5

-- 9. Count the number of content items in each genre

SELECT 
UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
COUNT(show_id) as total_content
FROM netflix
GROUP BY 1;

-- 10. Find each year and the average number of content release by india on netflix, return 
--     top 5 year with highest avg content release

SELECT
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
    COUNT(*) AS yearly_content,
    ROUND(
        COUNT(*)::numeric /
        (SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100,
        2
    ) AS avg_content_per_year
FROM netflix
WHERE country = 'India'
GROUP BY 1;

-- 11. List all movies that are documentaries 

SELECT *
FROM netflix
WHERE listed_in LIKE '%Documentaries%';

-- 12. Find all the content without a director

SELECT *
FROM netflix
WHERE Director IS NULL;

-- 13. Find how many movies does actor 'Salman Khan' appeared in last 10 years?

SELECT *
FROM netflix WHERE 
casts LIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
 
-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT
UNNEST(STRING_TO_ARRAY(casts, ',')) AS actors,
COUNT(*) AS movie_count
FROM netflix
WHERE country = 'India'
AND type = 'Movie'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field.
--     Label content containing these keywords as 'Bad' and all other content as 'Good'.
--    Count how many items fall into each category.

WITH new_table
AS 
(
SELECT 
*,
	CASE
	WHEN
		description ILIKE '%kill%' OR
 	    description ILIKE '%violence%' THEN 'Bad_content'
		ELSE 'Good_content'
	END category
FROM netflix
)
SELECT 
	category, 
	COUNT(*) as Total_content
FROM new_table
GROUP BY 1






