select distinct a.country from
	(select country from Customers
	union 
	select country from Suppliers) as a
	