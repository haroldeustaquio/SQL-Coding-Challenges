SELECT drug, total_sales-cogs as total_fit FROM pharmacy_sales
order by total_fit desc
limit 3