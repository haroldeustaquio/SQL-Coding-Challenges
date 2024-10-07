select b.mes,count(*) from
(SELECT 
  EXTRACT(month from event_date) as mes,
  user_id,
  count(*)
FROM user_actions
group by EXTRACT(month from event_date), user_id) as a
left join 
(SELECT 
  EXTRACT(month from event_date) as mes,
  user_id,
  count(*)
FROM user_actions
group by EXTRACT(month from event_date), user_id) as b
on a.mes + 1 = b.mes and a.user_id= b.user_id
where b.mes = 7
group by b.mes

