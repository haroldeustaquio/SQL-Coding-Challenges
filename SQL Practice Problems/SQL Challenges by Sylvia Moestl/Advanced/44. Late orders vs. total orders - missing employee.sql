select 
	a.EmployeeID, 
	a.LastName, 
	a.AllOrders, 
	b.LateOrders  
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
