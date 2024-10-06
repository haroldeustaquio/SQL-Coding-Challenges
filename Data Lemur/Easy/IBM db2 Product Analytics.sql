select sum_querie as unique_queries, count(*) as employee_count from
(select x.employee_id,sum(x.querie) as sum_querie from
(SELECT e.employee_id,
      (case when q.query_id is NULL then 0 else 1 end) as querie
  FROM employees as e
    left join queries as q
  on e.employee_id = q.employee_id and q.query_starttime BETWEEN '07/01/2023 00:00:00' and '09/30/2023 23:59:59') as x
GROUP BY x.employee_id) as y
group by sum_querie 
ORDER BY unique_queries











