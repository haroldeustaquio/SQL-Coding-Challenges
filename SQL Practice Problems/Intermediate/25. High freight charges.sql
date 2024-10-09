select top 3 ShipCountry, avg(Freight) as AverageFreight
from Orders
group by ShipCountry
order by AverageFreight desc