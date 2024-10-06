select a.manufacturer, count(*), sum(a.cogs) - sum(a.total_sales) as total_loss from
(select * from pharmacy_sales 
where cogs - total_sales > 0 ) as a
group by a.manufacturer
order by total_loss desc