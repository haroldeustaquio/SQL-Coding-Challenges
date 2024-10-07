select x.customer_id from
(SELECT 
  c.customer_id, 
  c.product_id, 
  p.product_category,
  dense_rank() over(PARTITION BY customer_id order by product_category) as ranking_to_3
FROM customer_contracts as c
inner join products as p
on c.product_id = p.product_id) as x
GROUP BY x.customer_id
having sum(x.ranking_to_3)=6