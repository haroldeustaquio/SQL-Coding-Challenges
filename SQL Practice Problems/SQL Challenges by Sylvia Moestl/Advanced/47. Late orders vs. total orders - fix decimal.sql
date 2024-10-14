select 
	a.EmployeeID, 
	a.LastName, 
	a.AllOrders, 
	case when b.LateOrders is null then 0 else b.LateOrders end,
	convert( decimal(10,2), 1.0*(case when b.LateOrders is null then 0 else b.LateOrders end)/(a.AllOrders)) as PercentLateOrders
from
	(select o.EmployeeID, e.LastName,count(*) as AllOrders
	from Orders o, Employees e
	where o.EmployeeID = e.EmployeeID
	group by o.EmployeeID, e.LastName) as a
left join 
	(select 
		o.EmployeeID, 
		count(*) as LateOrders
	from Orders o, Employees e
	where ShippedDate >= RequiredDate and o.EmployeeID=e.EmployeeID
	group by o.EmployeeID) as b
on a.EmployeeID =b.EmployeeID
