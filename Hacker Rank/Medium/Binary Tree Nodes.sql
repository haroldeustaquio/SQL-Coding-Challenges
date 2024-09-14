update BST set P=N
where P is null

select a.N,
(case
when cant is null then "Leaf"
when cant = 2 then "Inner"
else "Root"
end)
from BST as a
left join (SELECT P,count(coalesce(P,0)) as cant
FROM BST
group by P) as b
on a.N = b.P
order by a.N asc
