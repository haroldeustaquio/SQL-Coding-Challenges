SELECT b.city, count(*) FROM trades as a
inner join users as b
on a.user_id = b.user_id
where a.status != 'Cancelled'
group by b.city
order by count(*) desc
limit 3