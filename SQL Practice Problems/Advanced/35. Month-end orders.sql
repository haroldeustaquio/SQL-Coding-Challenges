select EmployeeID, OrderID, convert(date,OrderDate)
from Orders
where convert(date,OrderDate) = EOMONTH(OrderDate)