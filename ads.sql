

Select a.`platform`,a.clicks,a.OVK_name,min(a.time) as StartTime, max(a.time) as end_date, a.adtag
From ads as a
group by a.adtag
order by a.adtag DESC;