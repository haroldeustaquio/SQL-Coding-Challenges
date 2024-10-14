select * from
(select OrderID, Quantity, count(*) as cantidad from OrderDetails
where Quantity >= 60
group by OrderID, Quantity) as a
inner join 
(select * from OrderDetails) as b
on a.OrderID=b.OrderID and a.Quantity = b.Quantity and a.cantidad > 1
