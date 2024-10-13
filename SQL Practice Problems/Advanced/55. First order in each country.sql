select 
	a.ShipCountry,
	b.CustomerID,
	b.OrderID,
	convert(date,a.OrderDate) as OrderDate
from
(select 
	ShipCountry,
	min(OrderDate) as OrderDate 
from Orders
group by ShipCountry) as a
inner join 
Orders as b
on a.ShipCountry=b.ShipCountry and b.OrderDate = a.OrderDate