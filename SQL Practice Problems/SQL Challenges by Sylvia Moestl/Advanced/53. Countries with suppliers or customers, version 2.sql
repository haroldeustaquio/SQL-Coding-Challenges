select 
	c.Country as CustomerCountry,
	d.Country as SupplierCountry
from 
(
	select distinct a.country from
		(select country from Customers
		union 
		select country from Suppliers) as a
) as b
left join 
	(select distinct country
	from Customers) as c
on b.Country = c.Country
left join 
	(select distinct country
	from Suppliers) as d
on b.Country = d.Country
