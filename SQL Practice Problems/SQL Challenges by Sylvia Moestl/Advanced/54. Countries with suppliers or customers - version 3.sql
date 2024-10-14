select 
	b.Country as Country,
	case when d.TotalSuppliers is null then 0 else d.TotalSuppliers end as TotalSuppliers,
	case when c.TotalCustomers is null then 0 else c.TotalCustomers end as TotalCustomers
from 
(
	select distinct a.country from
		(select country from Customers
		union 
		select country from Suppliers) as a
) as b
left join 
	(select Country, count(*) as TotalCustomers
	from Customers
	group by Country) as c
on b.Country = c.Country
left join 
	(select
		Country, 
		count(*) as TotalSuppliers
	from Suppliers
	group by Country) as d
on b.Country = d.Country
