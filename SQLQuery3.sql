use stmgmt;
go

create procedure sp_GetCurrentDate
 as
begin
	SELECT CAST(GETDATE() AS DATE) as CurrentDate;
end
go

exec sp_GetCurrentDate;
go

drop procedure sp_GetCurrentDate

/*
	SCHOOL TABLE 
*/
delete dbo.TheSchool
go

insert into dbo.TheSchool
values('UNIVERSITY OF LIBERTY AND ARTS', '1960-04-06', 0)
go

select * from dbo.TheSchool
go



USE msdb;
GO
EXEC dbo.sp_add_schedule
    @schedule_name = N'[stmgmt].[dbo].[sp_UpdateYears]',
    @freq_type = 1,
    @active_start_time = 063000 ;
GO  

EXEC dbo.sp_delete_schedule
	@schedule_name = N'sp_TheSchoolAutoRun';
GO


create procedure sp_UpdateYears
 as
begin
	declare @curDate Date
	declare @difYear int
	set @curDate = (SELECT CAST(GETDATE() AS DATE))
	set @difYear = (select DATEDIFF(year, (select FoundationDate from TheSchool), @curDate))
	
	update TheSchool set Years = @difYear
end
go

exec sp_UpdateYears
go

drop procedure sp_UpdateYears
go

/*
	STUDENTSENIORITY TABLE 
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
begin
	select *
	from dbo.StudentSeniorities
	where Years = @stYear;
end
go


/*
	GENDER TABLE 
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
	ENROLSTATUS TABLE 
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
	DEPARTMENT TABLE 
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
	STUDENT TABLE 
*/
delete dbo.Students;
go

delete dbo.Students
where idDept > 5;
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
begin
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

execute sp_GetStudentSummary;
go

/*
	SUBJECTS TABLE
*/
-- Each department has 9 subjects for each students' seniority
create procedure sp_CreateSubjectData
	@MaxSubject int
  as
begin
	declare @id int
	declare @idStr varchar(50)
	declare @idDept int
	declare @idDeptStr varchar(50)
	declare @idSeniority int
	declare @idSeniorStr varchar(50)
	declare @maxDept int
	declare @maxSeniority int
	declare @nCount	int
	
	set @idDept = 1
	set @nCount = 1
	set @maxDept = (select count(*) from dbo.Departments)
	set @maxSeniority = (select count(*) from dbo.StudentSeniorities)
	
	while @idDept <= @maxDept
	begin
		set @idDeptStr = cast(@idDept as varchar)
		set @idSeniority = 1
		while @idSeniority <= @maxSeniority
		begin
			set @idSeniorStr = cast(@idSeniority as varchar)
			set @id = 1
			while @id <= @MaxSubject 
			begin
				set @idStr = cast(@id as varchar)
				
				insert into dbo.Subjects
				values (@nCount, 'Subject ' + @idDeptStr + '.' + @idSeniorStr + '.' + @idStr, 3, @idDept, @idSeniority)
				
				set @id = @id + 1
				set @nCount = @nCount + 1
			end
			set @idSeniority = @idSeniority + 1
		end
		set @idDept = @idDept + 1
	end
end
go	

drop procedure sp_CreateSubjectData;
go

exec sp_CreateSubjectData 5;
go

delete stmgmt.dbo.Subjects;
go

/*
	LECTURERS TABLE
*/

create procedure sp_CreateLecturerData
	@maxLect int
  as
begin
	declare @id int
	declare @idStr varchar(50)
	set @id = 1

	while @id <= @maxLect
	begin
		set @idStr = cast(@id as varchar)

		insert into stmgmt.dbo.Lecturers
		values (@id, 'FName ' + @idStr, 'MName ' + @idStr, 'LName ' + @idStr)
		set @id = @id + 1
	end
end
go

exec stmgmt.dbo.sp_CreateLecturerData 50
go

delete stmgmt.dbo.Lecturers;
go
/*
	CLASSES TABLE
*/

alter table Classes
alter column TaughtYear varchar not null;
go

alter table Classes
alter column TaughtYear date not null;
go
--drop table if exists dbo.Classes
--go

-- if this year hasn't had a class for the subject, create two classes for each subject
create procedure sp_CreateClassData
  as
begin
	declare @id int
	declare @idStr varchar(50)
	declare @idDept int
	declare @idDeptStr varchar(50)
	declare @idSeniority int
	declare @idSeniorStr varchar(50)
	declare @maxDept int
	declare @maxSeniority int
	declare @nCount	int
	
	set @idDept = 1
	set @nCount = 1
	set @maxDept = (select count(*) from dbo.Departments)
	set @maxSeniority = (select count(*) from dbo.StudentSeniorities)
	
	while @idDept <= @maxDept
	begin
		set @idDeptStr = cast(@idDept as varchar)
		set @idSeniority = 1
		while @idSeniority <= @maxSeniority
		begin
			set @idSeniorStr = cast(@idSeniority as varchar)
			set @id = 1
			while @id <= @MaxSubject 
			begin
				set @idStr = cast(@id as varchar)
				
				insert into dbo.Subjects
				values (@nCount, 'Subject ' + @idDeptStr + '.' + @idSeniorStr + '.' + @idStr, 3, @idDept, @idSeniority)
				
				set @id = @id + 1
				set @nCount = @nCount + 1
			end
			set @idSeniority = @idSeniority + 1
		end
		set @idDept = @idDept + 1
	end
end
go	


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