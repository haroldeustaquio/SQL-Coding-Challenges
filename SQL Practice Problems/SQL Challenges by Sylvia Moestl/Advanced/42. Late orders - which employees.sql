select 
	o.EmployeeID, 
	e.LastName, 
	(select count(*) 
	from Orders 
	where EmployeeID=o.EmployeeID) as AllOrders,
	count(*) as LateOrders
from Orders o, Employees e
where ShippedDate >= RequiredDate and o.EmployeeID=e.EmployeeID
group by o.EmployeeID, e.LastName
order by o.EmployeeID
