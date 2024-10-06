SELECT ROUND(a.mean::numeric, 1) from 
(SELECT sum(item_count*order_occurrences)/sum(order_occurrences) as mean
FROM items_per_order) as a