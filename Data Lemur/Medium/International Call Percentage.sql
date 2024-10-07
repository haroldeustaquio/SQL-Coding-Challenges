SELECT 
  round(100*(1- 1.0*sum(case when b.country_id = c.country_id then 1 else 0 end)/count(*)),1) as international_calls_pct
FROM phone_calls as a
inner join phone_info as b
on a.caller_id = b.caller_id
inner join phone_info as c
on a.receiver_id = c.caller_id
 