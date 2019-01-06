/*
Departments
	DEPT.<DeptNumber>
	17 departments: 01 --> 17
	DEPT.11
	
Students 
	STUD.<EntranceYear>.<DeptNumber>.<StudentNumber>
	STUD.06.04.000183
	
	Students have to earn at least 53 credits to graduate.
	
Subjects
	With a subject that two or more departments provide to students, 
		let consider they are 2 different subjects.
	Each department, each student year, there are 7 subjects.
	Each subject has 2 - 4 credits.
	Therefore, at least 14 credits per year. At least 56 credits per course.
	There are 17 departments x 7 subjects/year x 4 years = 476 subjects in total.

	SUBJ.<StudentYear>.<DeptNumber>.<SubjectNumber>
	SUBJ.1.07.0045
	SUBJ.2.07.0166
	
	
	
Classes
	In a year, there are two classes of each subject provided to students.
	CLSS.<StudentYear>.<DeptNumber>.<SubjectNumber>.<CurrentYear>.<SemesterNumber>.A-B
	CLSS.01.07.0045.19.03.A
	CLSS.01.07.0045.19.03.B
	
	Registration:
		If a subject has number of registered students of the same StudentYear or greater, greater than 20, the class is organized in the next semester.
		First come first serve.
		The maximum students per class is 50. If registered number is bigger than 50, divide into 2 classes.
	
R
		
Semesters
	There are 3 semesters per year.
	01: From Sept 01 to Dec 31, 1st semester.
	02: From Jan 01 to April 30, 2nd semester.
	03: From May 01 to August 31, 3rd semester.

Registration
	REGS.<DeptNumber>.<SubjectNumber>.<StudentNumber>
	REGS.07.0045.000183

	Time table is created at the end of each semester. It is for the next semester. 
	Do querying in the Enrollment table and retrieve all subjects that have registration bigger than 20.
	In case the registration number is lower than 20, drop the class and delete all the class' registration.

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
