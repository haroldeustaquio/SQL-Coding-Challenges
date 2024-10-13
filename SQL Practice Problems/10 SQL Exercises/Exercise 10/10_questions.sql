-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE

	select b.id,b.name,c.address,c.updatedate from people as b 
	inner join
	(select * from
	(select id,address,updatedate, ROW_NUMBER() over(partition by id order by address) as alias
	from address) as a
	where a.alias=1) as  c
	on b.id = c.id


-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
    -- i.e., the joined table should have the same number of rows as table PEOPLE

	select b.id,b.name,c.address,c.updatedate from people as b 
	inner join
	(select * from
	(select id,address,updatedate, ROW_NUMBER() over(partition by id order by address desc) as alias
	from address) as a
	where a.alias=1) as  c
	on b.id = c.id