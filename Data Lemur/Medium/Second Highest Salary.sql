select a.salary as second_highest_salary from
(SELECT *, row_number() over(ORDER BY salary desc) as ranking
FROM employee) as a
where a.ranking = 2