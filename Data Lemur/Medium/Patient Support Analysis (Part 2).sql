SELECT
  round(100.0*sum(case when call_category = 'n/a' or call_category is NULL  then 1 else 0 end)/count(*),1)
FROM callers