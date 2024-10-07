SELECT a.user_id,a.tweet_date ,
round(1.0*(a.tweet_count+COALESCE(b.tweet_count,0)+COALESCE(c.tweet_count,0))/
((case when a.tweet_date is null then 0 else 1 end)+
(case when b.tweet_date is null then 0 else 1 end)+
(case when c.tweet_date is null then 0 else 1 end)),2)
 as sum_cant_prom
FROM tweets as a 
left join tweets as b
on a.user_id = b.user_id and a.tweet_date - INTERVAL '1 day' = b.tweet_date
left join tweets as c
on a.user_id = c.user_id and b.tweet_date - INTERVAL '1 day' = c.tweet_date
order by a.user_id, a.tweet_date asc