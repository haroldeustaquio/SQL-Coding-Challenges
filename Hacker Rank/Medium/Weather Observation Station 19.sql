select replace(cast(cast(floor((sqrt(
    power(max(lat_n)-min(lat_n),2)*1.0000+
    power(max(long_w)-min(long_w),2)*1.0000))*10000) as integer)/10000.0 as varchar),"000","")
    from station