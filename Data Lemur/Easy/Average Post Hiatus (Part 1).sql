select a.user_id, extract(day from (b.maximo-a.minimo)) as days_between from 
(SELECT user_id, min( post_date) as minimo FROM posts
GROUP BY user_id) as a
inner join 
(SELECT user_id, max( post_date) as maximo FROM posts
GROUP BY user_id) as b
on a.user_id = b.user_id
where  extract(day from (b.maximo-a.minimo)) > 0 
and EXTRACT(year from b.maximo) = 2021 and 
EXTRACT(year from a.minimo) = 2021