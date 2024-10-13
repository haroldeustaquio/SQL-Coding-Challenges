select top 3 ShipCountry, avg(Freight) as AverageFreight
from Orders
where OrderDate >=  dateadd(YY,-1, (select max(orderdate) from Orders))
group by ShipCountry
order by AverageFreight desc