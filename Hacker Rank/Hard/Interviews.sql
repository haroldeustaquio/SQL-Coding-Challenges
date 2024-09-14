select tbl1.contest_id, tbl1.hacker_id, tbl1.name, tbl1.ts, tbl1.tas, tbl2.tv, tbl2.tuv from
(select a.contest_id, a.hacker_id, a.name, sum(d.total_submissions) as ts, sum(d.total_accepted_submissions) as tas
from contests as a, colleges as b, challenges as c, submission_Stats  as d
where a.contest_id = b.contest_id and b.college_id = c.college_id and c.challenge_id = d.challenge_id 
group by a.contest_id, a.hacker_id, a.name
having sum(d.total_submissions) + sum(d.total_accepted_submissions) > 0) as tbl1
inner join 
(select a.contest_id, a.hacker_id, a.name, sum(d.total_views) as tv , sum(d.total_unique_views) as tuv 
from contests as a, colleges as b, challenges as c, view_stats as d
where a.contest_id = b.contest_id and b.college_id = c.college_id and c.challenge_id = d.challenge_id 
group by a.contest_id, a.hacker_id, a.name
having sum(d.total_views) + sum(d.total_unique_views) > 0) as tbl2
on tbl1.contest_id = tbl2.contest_id and tbl1.hacker_id = tbl2.hacker_id and tbl1.name = tbl2.name
order by tbl1.contest_id
