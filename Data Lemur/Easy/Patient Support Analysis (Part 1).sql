select count(*) as policy_holder_count from 
(SELECT policy_holder_id, count(*) FROM callers
group by policy_holder_id
having count(*)>=3) as a