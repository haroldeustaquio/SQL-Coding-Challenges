select e.EmployeeID, e.LastName, p.ProductName, d.Quantity
from Employees as e, Orders as o, OrderDetails as d, Products as p
where e.EmployeeID = o.EmployeeID and o.OrderID=d.OrderID and p.ProductID=d.ProductID
order by o.OrderID, p.ProductID