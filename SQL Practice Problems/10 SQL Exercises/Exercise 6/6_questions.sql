-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.

	select c.name as ProjectName, a.name, c.hours from scientists as a
	inner join AssignedTo as b
	on b.scientist = a.SSN
	inner join Projects as c
	on b.project = c.code
	order by ProjectName asc, a.name asc

-- 6.2 Select the project names which are not assigned yet

	select a.name from projects as a
	left join assignedto as b
	on a.code = b.project
	where b.scientist is null
