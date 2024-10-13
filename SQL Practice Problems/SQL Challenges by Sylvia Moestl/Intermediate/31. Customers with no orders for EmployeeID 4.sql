select customerID from  Customers
where CustomerID not in (
	select distinct c.CustomerID from Customers as c
	left join Orders as o
	on c.CustomerID=o.CustomerID
	where EmployeeID=4
)