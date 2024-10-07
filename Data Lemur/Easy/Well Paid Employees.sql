SELECT a.employee_id, a.name FROM employee as a
inner join employee as b
on a.manager_id = b.employee_id
where a.salary > b.salarys