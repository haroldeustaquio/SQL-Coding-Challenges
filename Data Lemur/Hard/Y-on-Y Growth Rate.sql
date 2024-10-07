select a.anio, a.product_id,a.curr_year_spend ,b.prev_year_spend,
    round(100.0*(a.curr_year_spend - b.prev_year_spend)/b.prev_year_spend,2) as yoy_rate
from
(SELECT 
  EXTRACT(year from transaction_date) as anio,
  product_id,
  sum(spend) as curr_year_spend
FROM user_transactions
GROUP BY EXTRACT(year from transaction_date), product_id) as a
left join 
(SELECT 
  EXTRACT(year from transaction_date) as anio,
  product_id,
  sum(spend) as prev_year_spend
FROM user_transactions
GROUP BY EXTRACT(year from transaction_date), product_id) as b
on a.anio - 1 = b.anio and a.product_id = b.product_id
order by product_id,anio, curr_year_spend,prev_year_spend