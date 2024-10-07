select measurement_time::date,
  sum(case when b.ranking%2=0 then b.measurement_value else 0 end) as even_sum,
  sum(case when b.ranking%2=1 then b.measurement_value else 0 end) as odd_sum
from 
(
SELECT 
  *, rank() over(PARTITION BY EXTRACT(day from measurement_time) order by measurement_time asc) as ranking
FROM measurements
) as b
GROUP BY measurement_time::date
order by measurement_time::date asc