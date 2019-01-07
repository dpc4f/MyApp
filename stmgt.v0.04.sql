/*
Departments
	DEPT.<DeptNumber>
	17 departments: 01 --> 17
	DEPT.11
	
Students 
	STUD.<EntranceYear>.<DeptNumber>.<StudentNumber>
	STUD.15.04.100971
	
	Students have to earn at least 55 credits to graduate.
	
Subjects
	SUBJ.<StudentYear>.<DeptNumber>.<SubjectNumber>
	SUBJ.1.07.0045
	SUBJ.2.07.0166
	
	With a subject that two or more departments provide to students, 
		let consider they are 2 different subjects.
	Each department, each student year, there are 7 subjects.
	Each subject has 2 - 4 credits.
	Therefore, at least 14 credits per year. At least 56 credits per course.
	There are 17 departments x 7 subjects/year x 4 years = 476 subjects in total.

	
	
Classes
	In a year, there are two classes of each subject provided to students.
	CLSS.<StudentYear>.<DeptNumber>.<SubjectNumber>.<CurrentYear>.<SemesterNumber>.A-B
	CLSS.01.07.0045.19.02.A
	CLSS.01.07.0045.19.02.B
	
EnRollments

	ENRO.<SubjectNumber>.<StudentNumber>.<TaughtYear>
	ENRO.0045.100044.15

	count(ENRO.<DeptNumber>.<SubjectNumber>.<TaughtYear>.<TaughtSemester>.*) <= 100
		
Registration
	REGS.<DeptNumber>.<SubjectNumber>.<StudentNumber>
	REGS.07.0045.000183

	Time table is created at the end of each year. It is for the next year. 
	at the current time, consider that each year has one semester.
	Do querying in the Enrollment table and retrieve all subjects that have registration bigger than 20.
	In case the registration number is lower than 20, drop the class and delete all the class' registration.
	The maximum students per class is 50. If registered number is bigger than 50, divide into 2 classes.
	First come first serve. If the registration number is bigger than 100, exlude ones that come later.

Genders
	GEND.<GenderNumber>
	GEND.1
	GEND.2

StdTittle
	STI.<TitleNumber>
	STI.1
	STI.2
*/

alter table TheSchool
alter column FoundationDay date not null
go
