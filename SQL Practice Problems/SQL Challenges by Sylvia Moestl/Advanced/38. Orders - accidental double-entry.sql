select OrderID from
(select OrderID, Quantity, count(*) as cantidad from OrderDetails
where Quantity >= 60
group by OrderID, Quantity) as a
where a.cantidad > 1
