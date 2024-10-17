/*
1. Observe the result of running this SQL command to show the name, continent and population of all countries.
*/
SELECT name, continent, population FROM world


/*
2. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
*/
SELECT name FROM world
WHERE population > 200000000


/*
3. Give the name and the per capita GDP for those countries with a population of at least 200 million.
*/
select name, gdp/population from world
where population > 200000000


/*
4. Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
*/
select name, population/1000000 from world
where continent = 'South America'


/*
5. Show the name and population for France, Germany, Italy
*/
select name, population
from world
where name in ('France', 'Germany', 'Italy')


/*
6. Show the countries which have a name that includes the word 'United'
*/
select name from world
where name like '%United%'


/*
7. Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.

Show the countries that are big by area or big by population. Show name, population and area.
*/
select name, population, area
from world
where area >= 3000000 or population > 250000000


/*
8. Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
*/
select name, population, area
from world
where area >= 3000000 xor population > 250000000



/*
9. Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'
*/
select name, round(population/1000000,2) , round(GDP/1000000000,2) from world 
where continent = 'South America'



/*
10. Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
*/
select name, round(gdp/(population*1000),0)*1000 from world
where GDP > 1000000000000



/*
11. Show the name and capital where the name and the capital have the same number of characters.
*/
SELECT name, capital
FROM world
WHERE length(name) = length(capital)



/*
12. Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
*/
SELECT name, capital
FROM world
where LEFT(name,1) = left(capital,1) and name != capital



/*
12. Find the country that has all the vowels and no spaces in its name.
*/
SELECT name
FROM world
WHERE name not LIKE '% %' and name like '%a%' and name like '%e%' and name like '%i%'and name like '%o%' and name like '%u%'