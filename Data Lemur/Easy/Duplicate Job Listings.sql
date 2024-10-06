select count(*) as duplicate_companies from 
(SELECT 
  company_id, 
  row_number() over(PARTITION BY company_id order by company_id) as ord  
FROM job_listings) as a
where a.ord = 2 