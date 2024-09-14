select a.hacker_id, a.name from hackers as a
inner join submissions as s
on s.hacker_id = a.hacker_id
inner join challenges as c
on s.challenge_id = c.challenge_id
inner join Difficulty as d
on d.difficulty_level = c.difficulty_level
where s.score - d.score = 0
group by a.hacker_id, a.name
having count(*)>1
order by count(*) desc, a.hacker_id asc
