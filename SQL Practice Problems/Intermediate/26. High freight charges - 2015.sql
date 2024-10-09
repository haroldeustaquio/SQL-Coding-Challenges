select top 3 ShipCountry, avg(Freight) as AverageFreight
from Orders
where year(OrderDate) = 2015
group by ShipCountry
order by AverageFreight desc