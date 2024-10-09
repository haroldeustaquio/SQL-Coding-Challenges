select CustomerID, Companyname, region from
(select CustomerID, Companyname, region, (case when Region is null then 1 else 0 end) as temp
from Customers) as a
order by temp, Region, CustomerID