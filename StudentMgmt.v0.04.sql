/*
Departments
	DEPT.<DeptNumber>
	17 departments: 01 --> 17
	DEPT.11
	
Students 
	STUD.<EntranceYear>.<DeptNumber>.<StudentNumber>
	STUD.06.04.000183
	
	Students have to earn at least 57 credits to graduate.
	
Subjects
	With a subject that two or more departments provide to students, 
		let consider they are 2 different subjects.
	SUBJ.<StudentYear>.<DeptNumber>.<SubjectNumber>
	SUBJ.02.07.0045
	
	Each subject has 2 - 4 credits.
	
Classes
	In a year, there are two classes of each subject provided to students.
	CLSS.<StudentYear>.<DeptNumber>.<SubjectNumber>.<CurrentYear>.<SemesterNumber>.A-B
	CLSS.02.07.0045.19.03.A
	CLSS.02.07.0045.19.03.B
	
	Registration:
		If a subject has number of registered students of the same StudentYear or greater, greater than 20, the class is organized in the next semester.
		First come first serve.
		The maximum students per class is 50. If registered number is bigger than 50, divide into 2 classes.
		
		
Semesters
	There are 3 semesters per year.
	01: From Sept 01 to Dec 31, 1st semester.
	02: From Jan 01 to April 30, 2nd semester.
	03: From May 01 to August 31, 3rd semester.
*/

alter table TheSchool
alter column FoundationDay date not null
go

alter table Departments
add DeptNumb int not null
go

exec sp_rename StdTitle, StdTitles
go