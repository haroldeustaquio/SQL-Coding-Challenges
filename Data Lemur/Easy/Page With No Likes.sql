SELECT a.page_id FROM pages as a
left join page_likes as b
on a.page_id = b.page_id
where b.user_id is null
order by a.page_id asc