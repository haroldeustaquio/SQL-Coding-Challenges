select b.category, b.product, b.total as total_spend from
(
select 
  a.category, 
  a.product, 
  a.total, 
  RANK() over(PARTITION BY a.category order by a.total desc) as ord 
from
(
  SELECT category, product, sum(spend) as total
  FROM product_spend
  where EXTRACT(year from transaction_date) = 2022
  group by category, product) as a
) as b
where b.ord <= 2