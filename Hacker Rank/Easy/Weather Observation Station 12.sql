SELECT distinct city 
FROM station 
WHERE LEFT(city, 1) NOT IN ('a', 'e', 'i', 'o', 'u') and right(city, 1) NOT IN ('a', 'e', 'i', 'o', 'u');