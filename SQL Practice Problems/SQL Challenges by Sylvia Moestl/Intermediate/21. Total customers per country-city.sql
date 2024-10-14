select Country ,City, count(*) as TotalCustomer
from Customers
group by Country, City
order by TotalCustomer desc