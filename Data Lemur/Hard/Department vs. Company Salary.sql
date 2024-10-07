select e.department_id, TO_CHAR(s.payment_date, 'MM-YYYY') as mes, 
case when avg(amount) > (select avg(amount) from salary) then 'higher' else 'lower' end
from employee as e
inner join 
salary as s
on e.employee_id = s.employee_id and EXTRACT(month from s.payment_date) = 3
group by e.department_id, TO_CHAR(s.payment_date, 'MM-YYYY')
