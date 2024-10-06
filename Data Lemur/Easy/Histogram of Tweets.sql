select a.cantidad as tweet_bucket, count(*) as users_num from
(SELECT user_id, COUNT(*) as cantidad FROM tweets
where extract(year from tweet_date) > 2021
GROUP BY user_id) as a
group by a.cantidad
