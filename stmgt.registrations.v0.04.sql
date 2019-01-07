select * from dbo.Registrations;

alter table dbo.Registrations
add RegYear int not null;

/*
Registration
	REGS.<DeptNumber>.<SubjectNumber>.<StudentNumber>.<CurrentYear>
	REGS.07.0045.000183.19

	Time table is created at the end of each year. It is for the next year. 
	At the current time, consider that each year has one semester.
	Do querying in the Enrollment table and retrieve all subjects that have registration bigger than 20.
	In case the registration number is lower than 20, dont' create the class and delete all those registrations.
	The maximum students per class is 50. If registered number is bigger than 50, divide into 2 classes with {20}, {regs-20} students
	First come first serve. If the registration number is bigger than 100, exlude ones that come later.

-- create registration data of year 2018
-- students can only at most 7 subjets per year
-- students with entranceYear 15 register at least 2 subjects [2..7], those students can register all subjects in the department
-- students with entranceYear 16 register at least 3 subjects [3..7], those students can register all, except subjects for senior ones
-- students with entranceYear 17,18 register at least 4 subjects [4..7], ..., 

	Time table and classes is created based on Registrations
	
	For year 2018, generate data so that there are subjects have lower than 20 regs, from [20-50] regs, from [50-100] regs, greater than 100 regs

	create list of subjects that will have lower than 20 regs 5%
	if there are the 20th registration for the subjects, decline it
	
	create list of the subjects that will have [20-50] regs 20%
	create list of the subjects that will have [50-100] regs 10%
	create list of the subjects that will have greater than 100 regs 15%	
	other subjects is random
*/


select *
from Subjects

create procedure sp_DivideSubjestsIntoGroups
  as
begin
	declare @MAX_SUBJECT_NUMBER int

	set @MAX_SUBJECT_NUMBER = (select max(SubjectNumber) from dbo.Subjects)

	declare @nGroup01 int
	set @nGroup01 = cast((@MAX_SUBJECT_NUMBER * 0.05) as int)

	declare @nGroup02 int
	set @nGroup02 = cast((@MAX_SUBJECT_NUMBER * 0.6) as int)

	declare @nGroup03 int
	set @nGroup03 = cast((@MAX_SUBJECT_NUMBER * 0.2) as int)

	declare @nGroup04 int
	set @nGroup04 = cast((@MAX_SUBJECT_NUMBER * 0.15) as int)

	-- generate a random number (SbjNumber) and add it to Group01

end












