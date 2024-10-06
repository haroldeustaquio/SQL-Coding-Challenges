SELECT 
  EXTRACT(month from submit_date) as mth,
  product_id,
  ROUND(avg(stars),2) as avg_starts
FROM reviews
group by EXTRACT(month from submit_date), product_id
order by mth asc