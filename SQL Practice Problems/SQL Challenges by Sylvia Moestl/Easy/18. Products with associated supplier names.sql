select P.ProductID, P.ProductName, S.CompanyName from Products as p, Suppliers as S
where P.SupplierID = S.SupplierID