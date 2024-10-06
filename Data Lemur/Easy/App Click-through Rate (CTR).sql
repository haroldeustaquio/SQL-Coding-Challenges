select a.app_id, round(100.0*b.click/a.impression,2)  as ctr from 
(select app_id, event_type, count(*) as impression from  events
where event_type ='impression' and EXTRACT(year from timestamp) = 2022
group by app_id, event_type) as a
inner join
(select app_id, event_type, count(*) as click from  events
where event_type ='click' and EXTRACT(year from timestamp) = 2022
group by app_id, event_type) as b
on a.app_id = b.app_id