-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".

	select name from Package as a, client as c
	where a.recipient = c.accountnumber and a.weight = 1.5

-- 7.2 What is the total weight of all the packages that he sent?

	select sender, sum(weight) from package
	group by sender
	having sender = 2
