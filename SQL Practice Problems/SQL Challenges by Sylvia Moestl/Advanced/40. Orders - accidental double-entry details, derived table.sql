Select  
    OrderDetails.OrderID 
    ,ProductID 
    ,UnitPrice 
    ,OrderDetails.Quantity 
    ,Discount 
From OrderDetails  
    Join ( 
        Select  
            OrderID,
			Quantity
        From OrderDetails 
        Where Quantity >= 60 
        Group By OrderID, Quantity 
        Having Count(*) > 1 
    )  PotentialProblemOrders 
        on PotentialProblemOrders.OrderID = OrderDetails.OrderID and PotentialProblemOrders.Quantity = OrderDetails.Quantity
Order by OrderID, ProductID 