select OrderID,convert(char(10),OrderDate,103), ShipName
from Orders
where OrderID < 10300