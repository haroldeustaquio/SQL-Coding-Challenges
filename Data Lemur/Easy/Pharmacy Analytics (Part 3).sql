SELECT manufacturer, '$' || CAST(round(sum(total_sales)/1000000,0) as varchar) || ' million' as sales_mil
FROM pharmacy_sales
group by manufacturer
order by round(sum(total_sales)) desc