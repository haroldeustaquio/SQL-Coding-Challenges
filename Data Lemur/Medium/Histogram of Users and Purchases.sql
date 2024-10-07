select 
  a.datetrans,
  a.user_id,
  count(*) as purchase_count 
from 
  (SELECT max(transaction_date) as datetrans, user_id FROM user_transactions
  group by user_id) as a
left join user_transactions as b
on a.datetrans = b.transaction_date and a.user_id = b.user_id
GROUP BY a.datetrans, a.user_id
order by a.datetrans, a.user_id