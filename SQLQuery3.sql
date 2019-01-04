use stmgmt;
go

/*
	SCHOOL TABLE DATA
*/
delete dbo.TheSchool
go

insert into dbo.TheSchool
values('The School Of Liberty And Arts', 1960, 59)
go

select * from dbo.TheSchool
go

/*
	STUDENTSENIORITY TABLE DATA
*/
delete dbo.StudentSeniority
go

insert into dbo.StudentSeniorities
values(1, 'Freshman', 1)
insert into dbo.StudentSeniorities
values(2, 'Sophomore', 2)
insert into dbo.StudentSeniorities
values(3, 'Junior', 3)
insert into dbo.StudentSeniorities
values(4, 'Senior', 4)
insert into dbo.StudentSeniorities
values(5, 'Senior 2', 5)
go

drop procedure sp_GetSeniority;
go


if (OBJECT_ID('sp_GetSeniority') is not null)
	drop procedure dbo.sp_GetSeniority
go

create procedure sp_GetSeniority
	@stYear int
as
	select *
	from dbo.StudentSeniorities
	where Years = @stYear;
go


/*
	GENDER TABLE DATA
*/

delete dbo.Genders
go

insert into dbo.Genders
values (1, 'Male')
go

insert into dbo.Genders
values (2, 'Female')
go

insert into dbo.Genders
values (3, 'Other')
go

select * from Genders
go

/*
	ENROLSTATUS TABLE DATA
*/
delete dbo.EnrollmentStatuses
go

insert into dbo.EnrollmentStatuses
values (1, 'RollingIn')
go

insert into dbo.EnrollmentStatuses
values (2, 'Passed')
go

insert into dbo.EnrollmentStatuses
values (3, 'Failed')
go

select * from dbo.EnrollmentStatuses
go

/*
	DEPARTMENT TABLE DATA
*/
delete dbo.Students
delete dbo.Departments 
go

if (OBJECT_ID('sp_CreateDepartmentData') is not null)
	drop procedure dbo.sp_CreateDepartmentData
go

create procedure sp_CreateDepartmentData 
	@MaxDept int
as
	declare @id int
	declare @idStr varchar(50)

	set @id = 1

	while @id <= @MaxDept
	begin
		set @idStr = cast(@id as varchar)
		insert into dbo.Departments
		values (@id, 'Dept ' + @idStr)
		set @id = @id + 1
	end
go

execute dbo.sp_CreateDepartmentData 30
go

select * from dbo.Departments
go

/*
	STUDENT TABLE DATA
*/
delete dbo.Students
go

if (OBJECT_ID('sp_GetStudentData') is not null)
	drop procedure dbo.sp_GetStudentData
go

create procedure sp_GetStudentData
	@stID int
as
	select *
	from dbo.Students
	where idStudent = @stID
go

if (OBJECT_ID('sp_CreateStudentData') is not null)
	drop procedure dbo.sp_CreateStudentData
go

create procedure sp_CreateStudentData
	@MaxStudent int
as
	/*
	begin
		execute ('delete dbo.Students');
	end
	*/

	declare @id int
	declare @idStr varchar(50)
	declare @idDept int
	declare @maxDept int
	
	set @idDept = 1
	
	set @maxDept = (select count(*) from dbo.Departments)
	while @idDept <= @maxDept
	begin
		set @id = 1
		while @id <= @MaxStudent 
		begin
			set @idStr = cast(@id as varchar)
			insert into dbo.Students
			values ((@idDept-1)*1500 + @id, 'First ' + @idStr, 'Middle ' + @idStr, 'Last ' + @idStr, 1, @idDept, 1)
			set @id = @id + 1
		end
	
		set @idDept = @idDept + 1
	end
go		

execute dbo.sp_CreateStudentData 1500
go

if (OBJECT_ID('sp_GetStudentSummary') is not null)
	drop procedure dbo.sp_GetStudentSummary
go

create procedure sp_GetStudentSummary
	@stID int
as
	select *
	from Students as s, Departments as d, TheSchool as t
	where s.idStudent = @stID and s.idDept = d.idDept
go

execute sp_GetStudentSummary 6
go

/*
	CREATE CLASSES DATA TABLE
*/

--drop table if exists dbo.Classes
--go


/*
	CREATE REQUIREMENTS DATA TABLE
*/
	
--drop table if exists dbo.Requirements
--go

delete dbo.Requirements
go

insert into dbo.Requirements
values (1, 'MIN_CREDITS_GRADUATION', 60)
go

insert into dbo.Requirements
values (2, 'MIN_GPA', 2.00)
go



/*
	STORE PROCEDURE TO RETRIEVE STUDENT SUMMARIZED INFORMATION
*/

create procedure sp_StudentInfor
	@ID int
as
	select *
	from Students
	where idStudent = @ID
go