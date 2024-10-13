select OrderID, CustomerID, ShipCountry  from Orders
where ShipCountry in ('France', 'Belgium')
