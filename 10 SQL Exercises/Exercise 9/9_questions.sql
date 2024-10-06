-- 9.1 give the total number of recordings in this table
	
	select count(*) as total_number from [cran_logs_2015-01-01]

-- 9.2 the number of packages listed in this table?

	select count(distinct _package_) from [cran_logs_2015-01-01]

-- 9.3 How many times the package "Rcpp" was downloaded?

	select count(*) from [cran_logs_2015-01-01]
	where _package_ = 'Rcpp'

-- 9.4 How many recordings are from China ("CN")?

	select count(*) from [cran_logs_2015-01-01]
	where _country_ = 'CN'

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.

	select _package_, count(*) as count_ from [cran_logs_2015-01-01]
	group by _package_ 
	order by count_ desc

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM

	SELECT _package_, COUNT(*) AS count_
	FROM [cran_logs_2015-01-01]
	WHERE CAST(_time_ AS TIME) BETWEEN '09:00:00' AND '11:00:00'
	GROUP BY _package_
	ORDER BY count_ DESC;


-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
--    Select based on a given list.

	select count(*) from [cran_logs_2015-01-01]
	where _country_ in ('CN','JP','SG')

-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")

	select _country_,count(*) from [cran_logs_2015-01-01]
	group by _country_
	having 	count(*) > (select count(*) from [cran_logs_2015-01-01] where _country_ = 'CN')


-- 9.9 Print the average length of the package name of all the UNIQUE packages
	
	select avg(len(a._package_))
	from (select distinct _package_ from [cran_logs_2015-01-01]) as a


-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).

	select a._package_, a.count_ from 
	(select _package_, count(*) as count_, ROW_NUMBER() over(order by count(*) desc) as number from [cran_logs_2015-01-01]
	group by _package_) as a
	where a.number = 2

-- 9.11 Print the name of the package whose download count is bigger than 1000.

	select _package_, count(*) as count_ from [cran_logs_2015-01-01]
	group by _package_
	having count(*) > 1000

-- 9.12 The field "r_os" is the operating system of the users.
-- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).

	select	substring(_r_os_,1,5), 
			round(count(*)*100.00/(select count(*) from [cran_logs_2015-01-01]),2) as porce 
	from [cran_logs_2015-01-01]
	group by substring(_r_os_,1,5)