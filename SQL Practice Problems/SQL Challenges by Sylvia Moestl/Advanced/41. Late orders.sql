select OrderID, OrderDate, RequiredDate,ShippedDate from Orders
where ShippedDate >= RequiredDate 