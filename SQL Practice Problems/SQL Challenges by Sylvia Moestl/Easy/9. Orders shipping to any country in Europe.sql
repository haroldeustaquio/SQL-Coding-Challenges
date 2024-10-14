select OrderID, CustomerID, ShipCountry  from Orders
where ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')