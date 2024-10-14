select ContactTitle, count(*) as TotalContactTitle from Customers
group by ContactTitle
order by TotalContactTitle desc
