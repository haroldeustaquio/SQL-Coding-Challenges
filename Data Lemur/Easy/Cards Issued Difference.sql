SELECT card_name, max(issued_amount)-min(issued_amount) as difference FROM monthly_cards_issued
group by card_name
order by difference DESC