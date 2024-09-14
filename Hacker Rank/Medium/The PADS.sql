select name + "(" +left(Occupation,1)+")" from OCCUPATIONS
order by name asc

select "There are a total of " + cast(count(Occupation) as varchar) + " " +lower(Occupation)+"s."
from OCCUPATIONS
group by Occupation
order by count(Occupation),lower(Occupation)