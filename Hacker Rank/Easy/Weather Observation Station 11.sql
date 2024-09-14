SELECT distinct city 
FROM station 
WHERE right(city, 1) NOT IN ('a', 'e', 'i', 'o', 'u') or left(city, 1) NOT IN ('a', 'e', 'i', 'o', 'u');