select CustomerID from Customers
where CustomerID not in (select CustomerID from Orders)