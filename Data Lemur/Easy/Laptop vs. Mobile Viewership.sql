select 
sum(case when a.number ='mobile_views' then 1 else 0 end) as mobile_views,
sum(case when a.number ='laptop_views' then 1 else 0 end) as laptop_views
from 
(select device_type,
    CASE
        when device_type = 'laptop' then 'laptop_views'
    ELSE 'mobile_views'
    end as number
from viewership) as a