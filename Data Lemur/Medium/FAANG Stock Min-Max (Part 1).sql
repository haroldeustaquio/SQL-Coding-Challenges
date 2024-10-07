select 
  a.ticker, 
  TO_CHAR(b.date, 'Mon-YYYY') as highest_mth,
  a.highest_open, 
  TO_CHAR(c.date, 'Mon-YYYY') as lowest_mth,
  a.lowest_open
from
(SELECT ticker, max(open) as highest_open, min(open) as lowest_open
FROM stock_prices
GROUP BY ticker) as a
left join stock_prices as b
on a.ticker = b.ticker and a.highest_open = b.open
left join stock_prices as c
on a.ticker = c.ticker and a.lowest_open = c.open
order by a.ticker