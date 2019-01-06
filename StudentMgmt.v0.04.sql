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
*/

alter table TheSchool
alter column FoundationDay date not null
go

alter table Departments
add DeptNumb int not null
go

exec sp_rename StdTitle, StdTitles
go

insert into Departments
values ('DEPT.01', 'Vat Ly Dia Cau', 1);

insert into Departments
values ('DEPT.02', 'Vat Ly Khong Gian', 2);

insert into Departments
values ('DEPT.03', 'Toan Vat Ly', 3);

insert into Departments
values ('DEPT.04', 'Vat Ly Luong Tu', 4);

insert into Departments
values ('DEPT.05', 'Cong Nghe Nang Luong', 5);

insert into Departments
values ('DEPT.06', 'Vat Ly Vat Chat', 6);

insert into Departments
values ('DEPT.07', 'Khoa Hoc May Tinh', 7);

insert into Departments
values ('DEPT.08', 'TRI TUE NHAN TAO', 8);

insert into Departments
values ('DEPT.09', 'Cong Nghe Phan Mem', 9);

insert into Departments
values ('DEPT.10', 'He Thong Thong Tin', 10);

insert into Departments
values ('DEPT.11', 'Toan Va Cau Truc Du Lieu & Thuat Toan', 11);

insert into Departments
values ('DEPT.12', 'He Thong Nhung', 12);

insert into Departments
values ('DEPT.13', 'Ngon Ngu Lap Trinh', 13);

insert into Departments
values ('DEPT.14', 'Co So Du Lieu', 14);

insert into Departments
values ('DEPT.15', 'Mang Luoi Da Thiet Bi', 15);

insert into Departments
values ('DEPT.16', 'Vien Thong Thong Tin', 16);

insert into Departments
values ('DEPT.17', 'Thong Tin Ung Dung', 17);








