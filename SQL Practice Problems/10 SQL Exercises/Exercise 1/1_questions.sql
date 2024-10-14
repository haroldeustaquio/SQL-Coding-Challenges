-- 1.1 Select the names of all the products in the store.
	
	select name from [dbo].[Products]


-- 1.2 Select the names and the prices of all the products in the store.

	select name,price from [dbo].[Products]

-- 1.3 Select the name of the products with a price less than or equal to $200.


	select name from [dbo].[Products]
	where price <= 200

-- 1.4 Select all the products with a price between $60 and $120.

	select name, price from [dbo].[Products]
	where price between 60 and 120
	
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).

	select name, price*100 as price_in_cents from [dbo].[Products]

-- 1.6 Compute the average price of all the products.

	select AVG(price) as avg_price from [dbo].[Products]

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.

	select AVG(price) as avg_price from [dbo].[Products]
	where Manufacturer =  2

-- 1.8 Compute the number of products with a price larger than or equal to $180.
	
	select count(*) as cant from Products
	where price >= 100

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, 
--		and sort first by price (in descending order), and then by name (in ascending order).

	select name,price from Products 
	where price >=180 
	order by price desc

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.

		select * from products as a
		inner join Manufacturers as b
		on a.code = b.code

-- 1.11 Select the product name, price, and manufacturer name of all the products.

		select a.name, a.price, b.name as manufacturer_name from products as a
		inner join Manufacturers as b
		on a.Manufacturer = b.code

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.

		select avg(a.price) as avg_price, b.code as manufacturer_name from products as a
		inner join Manufacturers as b
		on a.Manufacturer = b.code
		group by b.code

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.

		select b.name as manufacturer_name ,avg(a.price) as avg_price from products as a
		inner join Manufacturers as b
		on a.Manufacturer = b.code
		group by b.name

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.

		select b.name as manufacturer_name ,avg(a.price) as avg_price from products as a
		inner join Manufacturers as b
		on a.Manufacturer = b.code
		group by b.name
		having avg(a.price) >= 150


-- 1.15 Select the name and price of the cheapest product.

	select name, price from products
	where price = (select min(price) from products)

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
		
		select b.manufacturer,b.product,a.max_price from
		(select manufacturer, max(price) as max_price from products
		group by manufacturer) as a inner join
		(select d.code, c.name as product, d.name as manufacturer, c.price
		from products as c,manufacturers as d 
		where c.manufacturer = d.code) as b
		on a.manufacturer = b.code and a.max_price = b.price


-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.

	insert into products values (11, 'Loudspeakers',70,2)


-- 1.18 Update the name of product 8 to "Laser Printer".

	update products set name = 'Laser Printer'
	where code=8

-- 1.19 Apply a 10% discount to all products.

	select code,name,price*0.9 as new_price, manufacturer 
	from products

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
	
	select code,name,
	(
		case 
			when price >120 then price*0.9
			else price
		end
	) as new_price, manufacturer 
	from products