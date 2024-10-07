select a.department_name, a.name, a.salary from 
(
  SELECT *, dense_rank() over(PARTITION BY e.department_id order by salary desc) as ord
  FROM employee as e
  inner join 
  department as d
  on e.department_id = d.department_id
) as a
where a.ord <=3
order by a.department_name asc, a.salary desc, a.name asc