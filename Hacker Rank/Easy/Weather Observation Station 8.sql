SELECT distinct city 
FROM station 
WHERE LEFT(city, 1) IN ('a', 'e', 'i', 'o', 'u') and right(city, 1) IN ('a', 'e', 'i', 'o', 'u') ;
