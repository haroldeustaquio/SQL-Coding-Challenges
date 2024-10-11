select top 10 o.OrderID, count(*) as TotalOrderDetails 
from Orders o, OrderDetails d
where d.OrderID = o.OrderID
group by o.OrderID
order by TotalOrderDetails desc