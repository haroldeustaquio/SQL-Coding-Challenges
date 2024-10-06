select a.user_id, a.spend, a.transaction_date from
(SELECT *, rank() over(PARTITION BY user_id order by transaction_date) as ranking 
FROM transactions) as a
where a.ranking = 3