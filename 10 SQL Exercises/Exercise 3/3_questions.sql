--3.1 Select all warehouses.

	select * from warehouses

--3.2 Select all boxes with a value larger than $150.

	select * from boxes where value > 150 

--3.3 Select all distinct contents in all the boxes.

	select distinct contents from boxes

--3.4 Select the average value of all the boxes.

	select avg(value) as promedio from boxes

--3.5 Select the warehouse code and the average value of the boxes in each warehouse.

	select code, avg(value) as promedio from boxes
	group by code
	
--3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.

	select code, avg(value) as promedio from boxes
	group by code
	having avg(value) > 150

--3.7 Select the code of each box, along with the name of the city the box is located in.

	select a.code,b.location from boxes as a, warehouses as b
	where a.warehouse = b.code

--3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
	
	select a.code, count(*) as cantidad from Warehouses as a, Boxes as b where a.Code = b.Warehouse
	group by a.Code

--3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).

	select a.code,a.Capacity, count(*) as cantidad from Warehouses as a, Boxes as b where a.Code = b.Warehouse
	group by a.Code, a.Capacity
	having count(*) > a.Capacity

--3.10 Select the codes of all the boxes located in Chicago.

	select b.code from Warehouses as a, Boxes as b 
	where a.Code = b.Warehouse and a.Location = 'Chicago'

--3.11 Create a new warehouse in New York with a capacity for 3 boxes.

	insert into Warehouses values (6,'New York',3)

--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.

	insert into Boxes values ('H5RT','Papers',200,2)

--3.13 Reduce the value of all boxes by 15%.
	
	update Boxes set value = value*0.85

--3.14 Remove all boxes with a value lower than $100.

	delete from boxes where value <100	

-- 3.15 Remove all boxes from saturated warehouses.

	delete from Boxes where Warehouse in (select c.code from
	(select a.code,a.Capacity, count(*) as cantidad from Warehouses as a, Boxes as b where a.Code = b.Warehouse
	group by a.Code, a.Capacity
	having count(*) > a.Capacity) as c)

-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

	create nonclustered index index_warehouse
	on boxes(warehouse)

-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

	select * from sys.indexes

-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

	drop index index_warehouse on boxes
