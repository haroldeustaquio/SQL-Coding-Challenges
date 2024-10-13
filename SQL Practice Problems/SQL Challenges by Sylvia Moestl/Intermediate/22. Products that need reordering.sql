select ProductID, ProductName, UnitsInStock, ReorderLevel
from Products
where UnitsInStock<ReorderLevel
order by productID asc