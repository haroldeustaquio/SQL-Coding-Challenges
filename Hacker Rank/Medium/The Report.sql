select 
(case 
    when b.grade <=7 then null
    else a.name
    end), b.grade, a.marks
from students as a
inner join grades as b
on  b.min_mark <= a.marks and  a.marks <= b.max_mark
order by b.grade desc, a.name asc 
