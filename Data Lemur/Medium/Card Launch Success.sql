select a.card_name, a.issued_amount from
(SELECT * , row_number() over(PARTITION BY card_name ORDER BY issue_year asc, issue_month asc) as order_row
FROM monthly_cards_issued) as a
where a.order_row = 1
order by a.issued_amount desc