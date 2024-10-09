select orderID, ShipCountry, OrderDate from Orders
where orderDate >'2015-12-31 00:00:00.000' and year(OrderDate) = 2015 and ShipCountry='France'
order by OrderDate desc