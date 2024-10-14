-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.

	select c.Name from Undergoes as a
	left join Trained_In as b
	on a.Physician = b.Physician and a.Procedures=b.Treatment 
	inner join Physician as c
	on c.EmployeeID = a.Physician
	where b.Physician is null

-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.


	select c.name,d.Name,a.DateUndergoes,e.name  from Undergoes as a
	left join Trained_In as b
	on a.Physician = b.Physician and a.Procedures=b.Treatment 
	inner join Physician as c
	on c.EmployeeID = a.Physician
	inner join Procedures as d
	on d.Code = a.Procedures
	inner join Patient as e
	on e.SSN = a.Patient
	where b.Physician is null


-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, 
	-- but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).

	select c.Name  from Undergoes as a
	left join Trained_In as b
	on a.Physician = b.Physician and a.Procedures=b.Treatment 
	inner join Physician as c
	on c.EmployeeID = a.Physician
	inner join Procedures as d
	on d.Code = a.Procedures
	where a.DateUndergoes > b.CertificationExpires and b.Physician is not null

-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure 
	-- was carried out, name of the patient the procedure was carried out on, and date when the certification expired.

	select c.Name,d.Name,a.DateUndergoes,e.Name, b.CertificationExpires  from Undergoes as a
	left join Trained_In as b
	on a.Physician = b.Physician and a.Procedures=b.Treatment 
	inner join Physician as c
	on c.EmployeeID = a.Physician
	inner join Procedures as d
	on d.Code = a.Procedures
	inner join Patient as e
	on e.SSN = a.Patient
	where a.DateUndergoes > b.CertificationExpires and b.Physician is not null


-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information:
	-- Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.

	select m.pacient, m.physician, m.Start, m.[End], m.ExaminationRoom, n.Name as Nurse, p.Name as PCP from
	(select c.EmployeeID,a.PrepNurse, b.PCP, b.Name as pacient, c.Name as physician, a.Start, a.[End], a.ExaminationRoom from Appointment as a, Patient as b, Physician as c 
	where a.Patient = b.SSN and a.Physician != b.PCP and c.EmployeeID = a.Physician) as m
	left join Nurse as n
	on m.PrepNurse = n.EmployeeID
	left join Physician as p
	on m.PCP = p.EmployeeID


-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. 
	-- There are no constraints in force to prevent inconsistencies between these two tables. 
	-- More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from 
	-- the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.

	select * from Undergoes as a 
	left join Stay as b
	on a.Stay = b.StayID
	where a.Patient != b.Patient

-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.

	select a.Name from Nurse as a 
	inner join On_Call as b
	on a.EmployeeID = b.Nurse
	inner join Room as c
	on c.BlockCode = b.BlockCode and b.BlockFloor = c.BlockFloor
	where c.RoomNumber = 123

-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.

	SELECT CAST(ExaminationRoom AS VARCHAR(255)) AS ExaminationRoom, COUNT(*) as cantidad
	FROM Appointment
	GROUP BY CAST(ExaminationRoom AS VARCHAR(255));


-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.

	select distinct a.Name as patient, x.Name as PCP from Patient as a
	left join Prescribes as b
	on a.SSN = b.Patient
	left join Stay as m
	on m.Patient = a.SSN
	left join Undergoes as c
	on c.Stay = m.StayID
	inner join Procedures as p
	on c.Procedures = p.Code
	inner join Appointment as q
	on q.Patient = a.SSN
	right join Nurse as n
	on n.EmployeeID = q.PrepNurse
	inner join Physician as x
	on x.EmployeeID = a.PCP
	right join Department as y
	on y.Head != x.EmployeeID
	where a.PCP = b.Physician and p.Cost > 5000