
select 
	a.CustomerGroup, 
	count(*) as TotalInGroup,
	1.0*count(*)/(select count(*) from
						(select 
								c.CustomerID,
								c.CompanyName,
								(
								case 
								when sum(d.Quantity*d.UnitPrice) <= 1000 then 'Low'
								when sum(d.Quantity*d.UnitPrice) <= 5000 then 'Medium'
								when sum(d.Quantity*d.UnitPrice) <= 10000 then 'High'
								else 'Very High'
								end) as CustomerGroup
							from Customers c, Orders o, OrderDetails d
							where c.CustomerID=o.CustomerID and o.OrderID =d.OrderID and year(o.OrderDate) = 2016
							group by c.CustomerID,c.CompanyName) as x)
from 
	(select 
		c.CustomerID,
		c.CompanyName,
		(
		case 
		when sum(d.Quantity*d.UnitPrice) <= 1000 then 'Low'
		when sum(d.Quantity*d.UnitPrice) <= 5000 then 'Medium'
		when sum(d.Quantity*d.UnitPrice) <= 10000 then 'High'
		else 'Very High'
		end) as CustomerGroup
	from Customers c, Orders o, OrderDetails d
	where c.CustomerID=o.CustomerID and o.OrderID =d.OrderID and year(o.OrderDate) = 2016
	group by c.CustomerID,c.CompanyName) as a
group by a.CustomerGroup
order by TotalInGroup desc


