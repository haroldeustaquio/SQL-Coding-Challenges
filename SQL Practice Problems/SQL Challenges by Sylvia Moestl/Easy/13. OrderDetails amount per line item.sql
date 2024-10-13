select OrderID, ProductID, UnitPrice, Quantity, UnitPrice*Quantity as TotalPrice
from OrderDetails
order by OrderID, ProductID