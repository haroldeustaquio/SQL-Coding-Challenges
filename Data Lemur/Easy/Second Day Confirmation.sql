SELECT c.user_id FROM texts as a
inner join texts as b
on  a.email_id = b.email_id and
    a.action_date + INTERVAL '1 day'= b.action_date
inner join emails as c
on c.email_id = a.email_id