/*
1. Change the query shown so that it displays Nobel prizes for 1950.
*/

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950


/*
2. Show who won the 1962 prize for literature.
*/

SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'literature'


/*
3. Show the year and subject that won 'Albert Einstein' his prize.
*/

SELECT yr , subject
FROM nobel
WHERE winner = 'Albert Einstein'


/*
4. Give the name of the 'peace' winners since the year 2000, including 2000.
*/

SELECT winner 
FROM nobel
WHERE yr >= 2000 and subject = 'peace'


/*
5. Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.
*/

SELECT yr, subject, winner 
FROM nobel
WHERE (yr between 1980 and 1989) and subject = 'literature'


/*
6. Show all details of the presidential winners:
    - Theodore Roosevelt
    - Thomas Woodrow Wilson
    - Jimmy Carter
    - Barack Obama
*/

SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt','Thomas Woodrow Wilson','Jimmy Carter', 'Barack Obama')


/*
7. Show the winners with first name John
*/

select winner from nobel where winner like 'John%'


/*
8. Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984
*/

select yr, subject, winner from nobel where yr = 1980 and subject='physics'
union
select yr, subject, winner from nobel where yr = 1984 and subject='chemistry'


/*
9. Show the year, subject, and name of winners for 1980 excluding chemistry and medicine
*/

select yr, subject, winner from nobel where yr = 1980 and subject not in ('chemistry','medicine')


/*
10. Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
*/

select yr, subject, winner from nobel where subject = 'medicine' and yr< 1910
union
select yr, subject, winner from nobel where subject = 'literature' and yr>= 2004


/*
11. Find all details of the prize won by PETER GRÜNBERG
*/

select * from nobel where winner = 'PETER GRÜNBERG'


/*
12. Find all details of the prize won by EUGENE O'NEILL
*/

select * from nobel where winner = "EUGENE O'NEILL"


/*
13. List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
*/

select winner, yr ,subject from nobel where winner like "Sir%"
order by yr desc, winner


/*
14. The expression subject IN ('chemistry','physics') can be used as a value - it will be 0 or 1.
*/

SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject not IN ('physics','chemistry') desc