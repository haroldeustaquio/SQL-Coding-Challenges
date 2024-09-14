select replace(cast(round(a.lat_n,4) as varchar(max)),'0000','') from 
(select row_number() over(order by lat_n desc) as cont, * from Station) as a
where a.cont = ((select count(*) from Station)+1)/2