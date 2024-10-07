SELECT 
  round(1.0*sum(case when signup_action = 'Confirmed' then 1 ELSE 0 end)/
  sum(case when signup_action = 'Confirmed' then 1 ELSE 1 end),2) as activation_rate
FROM texts