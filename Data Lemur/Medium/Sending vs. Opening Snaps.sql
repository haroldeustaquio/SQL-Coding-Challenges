select 
  b.age_bucket, 
  ROUND(b.send*100.0/(b.send+b.open),2) as send_perc,
  ROUND(b.open*100.0/(b.send+b.open),2) as open_perc
from
(select a.age_bucket,
sum(case when activity_type='send' then suma end) as send,
sum(case when activity_type='open' then suma end) as open
from
(SELECT age_bucket, activity_type, sum(time_spent) as suma
FROM activities as a
inner join age_breakdown as b
on a.user_id = b.user_id 
GROUP BY age_bucket, activity_type) as a
group by age_bucket) as b
order by age_bucket