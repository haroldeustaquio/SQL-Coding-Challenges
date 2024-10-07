select 
  a.employee_id, 
  (case when suma>quota then 'yes' else 'no' end) as made_quota
from
(SELECT employee_id, sum(deal_size) as suma FROM deals
group by employee_id) as a
inner join sales_quotas as b
on a.employee_id = b.employee_id
order by a.employee_id