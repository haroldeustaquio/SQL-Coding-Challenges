SELECT candidate_id FROM candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id 
having count(*) = 3
