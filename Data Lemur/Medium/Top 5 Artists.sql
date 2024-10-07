select y.artist_name, y.ranking from
(select 
  z.artist_name, 
  dense_rank() over(order by z.total desc) as ranking from
(select 
  x.artist_name, 
  sum(x.in_top_10) as total
from
(SELECT 
  a.artist_name,
  (case when g.rank <=10 then 1 else 0 end) as in_top_10
FROM artists as a
  inner join songs as s
    on a.artist_id = s.artist_id
  inner join global_song_rank as g
    on g.song_id = s.song_id) as x
  group by x.artist_name) as z) as y
where y.ranking <= 5s