select c.CategoryName, count(*) as TotalProducts
from Products as p, Categories as c
where p.CategoryID = c.CategoryID
group by c.CategoryName
order by TotalProducts desc