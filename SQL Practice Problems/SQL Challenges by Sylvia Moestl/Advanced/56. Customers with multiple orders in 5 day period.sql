use Northwind
go


select 
	a.OrderID,
	a.CustomerID,
	convert(date,a.OrderDate),
	b.OrderID,
	convert(date,b.OrderDate),
	DATEDIFF(day,a.OrderDate,b.OrderDate) as Daysbetween
from
	(select 
		*,
		ROW_NUMBER() over(partition by CustomerID order by OrderDate)  as ord
	from Orders) as a
inner join 
	(select 
		*,
		ROW_NUMBER() over(partition by CustomerID order by OrderDate)  as ord
	from Orders) as b
on a.ord + 1 =b.ord and a.CustomerID = b.CustomerID
where DATEDIFF(day,a.OrderDate,b.OrderDate) <=5
