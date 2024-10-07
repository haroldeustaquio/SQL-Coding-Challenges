SELECT item_count FROM items_per_order
where order_occurrences = (select max(order_occurrences) from items_per_order)