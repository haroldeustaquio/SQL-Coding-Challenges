select ProductID, ProductName,UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
from Products
where UnitsInStock+UnitsOnOrder<=ReorderLevel and Discontinued=0