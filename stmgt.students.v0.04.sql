-- Each department has 300 students per year
-- entrance year = [current year - 4, current year - 1]
-- student number is increased one by one

create procedure sp_GenerateStudentData  as
begin
	declare @MAX_YEAR int
	set @MAX_YEAR = 4
	declare @MAX_DEPT int
	set @MAX_DEPT = 17
	declare @MAX_STUDENT_PER_YEAR int
	set @MAX_STUDENT_PER_YEAR = 300
	
	declare @nStud int
	set @nStud = 1
	declare @nStudYear int -- number of students per year each department
	set @nStudYear = 1
	
	-- get the current year
	declare @CURRENT_YEAR int
	set @CURRENT_YEAR = YEAR(GETDATE()) % 100
	-- print @CURRENT_YEAR

	-- generate the id
	declare @idStudent varchar(50)
	declare @nYear int -- correspondent to students' year
	set @nYear = 1
	declare @nDept int	
	set @nDept = 1

	declare @firstName as varchar(50)
	declare @lastName as varchar(50)
	declare @idGender as varchar(50)

	while (@nYear <= @MAX_YEAR)
	begin
		set @nDept = 1
		while (@nDept <= @MAX_DEPT)
		begin
			set @nStudYear = 1
			while (@nStudYear <= @MAX_STUDENT_PER_YEAR)
			begin
				set @idStudent = 'STUD.' + cast((@CURRENT_YEAR-5+@nYear) as varchar(50)) + '.' + 
									dbo.fn_ZeroPad(@nDept, 2) + '.' + dbo.fn_ZeroPad(@nStud, 6)
				print @idStudent
				
				-- generate first name
				set @firstName = 'Firstn ' + CAST(@nStud as varchar(50))

				-- generate last name
				set @lastName = 'Lastn ' + CAST(@nStud as varchar(50))

				-- generate gender
				set @idGender = 'GEND.' + CAST((dbo.fn_Random(2)+1) as varchar(50))

				-- query idDept
				declare @idDept varchar(50)
				set @idDept = (select IdDept from dbo.Departments where @nDept = DeptNumb)
				print @idDept

				-- query idStdTitle
				declare @idStdtitle varchar(50)
				set @idStdtitle = (select IdTitle from dbo.StdTitles where @nYear = YearNumb)
				print @idStdTitle

				-- add to the table
				insert into dbo.Students
				values (@idStudent, @firstName, @lastName, @idGender, @idDept, @idStdtitle, @nStud)

				-- update counters				
				set @nStud = @nStud + 1
				set @nStudYear = @nStudYear + 1
			end
			set @nDept = @nDept + 1
		end
		set @nYear = @nYear + 1
	end
end

drop procedure dbo.sp_GenerateStudentData;

exec dbo.sp_GenerateStudentData;




select * from Students;

select DeptNumb
from Departments

select dbo.fn_ZeroPad(13, 3)

delete Students;


alter table dbo.Students
add StudNumber int not null;

exec sp_rename 'Students.IdStdTitle', 'IdStudTitle', 'COLUMN';

select * from Students;


declare @CURRENT_YEAR int
set @CURRENT_YEAR = YEAR(GETDATE()) % 100
print @CURRENT_YEAR


create procedure sp_UpdateStudentTitle
  as
begin
	declare @nStudNumber int
	set @nStudNumber = 1

	declare @MAX_STUDENT_NUMBER int
	set @MAX_STUDENT_NUMBER = (select max(Students.StudNumber) from Students)

	declare @idStudent varchar(50)
	while (@nStudNumber <= @MAX_STUDENT_NUMBER)
	begin
		set @idStudent = (select idStudent from Students where @nStudNumber = StudNumber)

		-- split the string to get entrance year
	end
end



create procedure sp_GetStudentSummary
	@idStudent nchar(20)
  as
begin
	select * 
	from Students as s, Departments as d, Genders as g, Enrollments as e
	where s.IdStudent = @idStudent and s.IdDept = d.IdDept and s.IdGender = g.IdGender and s.IdStudent = e.IdStudent
end

exec dbo.sp_GetStudentSummary 'STUD.15.01.100001   '

drop procedure dbo.sp_GetStudentSummary

select * 
from Students as s, Departments as d, Genders as g, Enrollments as e
where s.IdStudent = 'STUD.15.01.100001' and s.IdDept = d.IdDept and s.IdGender = g.IdGender and s.IdStudent = e.IdStudent


go