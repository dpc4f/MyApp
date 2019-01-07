select * from dbo.Registrations;

alter table dbo.Registrations
add RegYear int not null;

/*
Registration
	REGS.<DeptNumber>.<SubjectNumber>.<StudentNumber>.<CurrentYear>
	REGS.07.0045.000183.19

	Time table is created at the end of each year. It is for the next year. 
	at the current time, consider that each year has one semester.
	Do querying in the Enrollment table and retrieve all subjects that have registration bigger than 20.
	In case the registration number is lower than 20, drop the class and delete all the class' registration.
	The maximum students per class is 50. If registered number is bigger than 50, divide into 2 classes.
	First come first serve. If the registration number is bigger than 100, exlude ones that come later.

-- create registration data of year 2018
-- students with entranceYear 15 register at least 2 subjects [2..7]
-- students with entranceYear 16 register at least 3 subjects [3..7]
-- students with entranceYear 17,18 register at least 4 subjects [4..7]

*/
