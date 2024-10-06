SELECT  sender_id, count(*) as message_count FROM messages
where EXTRACT(month from sent_date) = 8 and  EXTRACT(year from sent_date) = 2022
group by sender_id 
order by message_count desc
limit 2