select c.CustomerID, d.OrderID, sum(d.Quantity*d.UnitPrice) as TotalOrderAmount
from Customers c, OrderDetails d, Orders o
where c.CustomerID= o.CustomerID and o.OrderID = d.OrderID and year(o.OrderDate) = 2016
group by c.CustomerID, d.OrderID
having sum(d.Quantity*d.UnitPrice) > 10000
order by TotalOrderAmount desc
