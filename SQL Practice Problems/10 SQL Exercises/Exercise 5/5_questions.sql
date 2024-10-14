-- 5.1 Select the name of all the pieces.

	select name from pieces

-- 5.2  Select all the providers' data. 

	select * from providers

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).

	select piece, avg(price) as avg_price from provides group by piece

-- 5.4  Obtain the names of all providers who supply piece 1.

	select provider from provides where piece = 1


-- 5.5 Select the name of pieces provided by provider with code "HAL".

	select provides.piece, pieces.name from provides,pieces where provider = 'HAL' and provides.piece = pieces.code

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).

		select a.piece, c.name, b.provider, a.max_price from
		(select piece,max(price) as max_price from provides group by piece) as a
		inner join provides as b
		on a.piece = b.piece and a.max_price = b.price	
		inner join pieces as c
		on c.code =b.piece


-- ---------------------------------------------
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.

	insert into provides values (1,'TNBC',7)

-- 5.8 Increase all prices by one cent.

	update provides set price = price +1
	
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).

	delete from provides where provider = 'RBT' and Piece=4

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).

	delete from provides where provider = 'RBT'

