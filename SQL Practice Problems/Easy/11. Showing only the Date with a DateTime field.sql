select FirstName,LastName,Title,convert(char(10),BirthDate,103) from Employees
order by BirthDate asc