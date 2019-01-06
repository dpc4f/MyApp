/*
	To create report of students
		- how many credits a student has at the reporting time
		- the min year is 15, max year is 19, correspondent to student year 1..5
		- every subject has at least 20 enrollments, at most 100 enrollments
		- assume that students 80% passed, 20% failed after the examination
		- students can retake the subjects again for a better result
		- the subjects' result is the last grade point
		- grade point is a random number from 0..5, inclusive
		- with year 15, only subjects with student year 01 is opened
		- now it is the senior year for students that have entrance year 15,
			then students with entrance year 15 are first ones who joined subjects having studentYear 1 
*/
create sp_GenerateEnrollData
	as
begin
	-- students with entrance year 15, subjects for freshman ones
	-- group into departments
	-- each student will join from 3..7 subjests each year
	/*
		for depts 1..17
			calculate the subject numbers from student year & dept number
			select random from 3..7 subject numbers
	*/
	declare @studNumber int
	set @studNumber = 1

	-- get deptId of the student
	declare @idDept varchar(50)
	set @idDept = (select Students.IdDept
					from Students
					where @studNumber = StudNumber)
	
	declare @subjectTbl table (IdSubject varchar(50))
	insert into @subjectTbl
	select tbl.IdSubject
	from dbo.fn_Select_AtLeast03_SubjectIds(@idDept, 'STI.1') as tbl -- get the subjects of the freshman ones
	order by tbl.IdSubject

	-- for each subject, make an enrollment of the student
	declare @nSbjNumber as int
	set @nSbjNumber = (select count(*) from @subjectTbl)
	declare @nCount as int
	set @nCount = 1
	while (@nCount <= @nSbjNumber)
	begin
		-- generate a random grade point
		declare @nGradePoint int
		set @nGradePoint = dbo.fn_Random(6) -- [0..5]

		-- taught year is the entrance year

		-- taught semester : TO BE CONTINUED, just filled the value 01
	end
end


-- calculate subject numbers and return as a table
-- input IdDept, IdStudTitle

create function fn_GetListSubjectId (@idDept as varchar(50), @idStudTitle as varchar(50))
	returns @rtnTable table(
		IdSubject varchar(50) not null
	)
  as
begin
	declare @tmpTable table (idSubject varchar(50))
	
	insert into @tmpTable
	select IdSubject
	from Subjects 
	where IdDept = @idDept and IdStdTitle = @idStudTitle

	-- this select return data
	insert into @rtnTable
	select IdSubject 
	from @tmpTable
	return
end

drop function dbo.fn_GetListSubjectId

select *
from dbo.fn_GetListSubjectId('DEPT.02', 'STI.1')


-- you have to sort the values after get the result table
create function fn_Select_AtLeast03_SubjectIds (@idDept as varchar(50), @idStudTitle as varchar(50))
	returns @rtnTable table(
		IdSubject varchar(50) not null
	)
  as
begin
	declare @tmpTable table (IdSubject varchar(50) not null)
	declare @sbjIdTable table (IdSubject varchar(50) not null)
	declare @nRandom int

	insert into @sbjIdTable
	select * 
	from dbo.fn_GetListSubjectId(@idDept, @idStudTitle)

	-- define slots, generate a random number in 3..7, inclusive
	declare @nSlot int
	set @nRandom = dbo.fn_Random(5) -- [0..4]
	set @nSlot = @nRandom + 3 -- [3..7]

	-- define ids, for each slot, generate a random number in 1..7, inclusive
	declare @nID int
	declare @nCnt int
	declare @nExist int
	declare @idTmp varchar(50)

	set @nCnt = 1
	while @nCnt <= @nSlot
	begin
		set @nExist = 1

		while (@nExist != 0)
		begin
			set @nID = dbo.fn_Random(7) -- [0..6]
			set @nID = @nID + 1 -- [1..7]
			set @idTmp = (SELECT IdSubject
							FROM (
								SELECT ROW_NUMBER () OVER (ORDER BY IdSubject) AS RowNum, *
								FROM @sbjIdTable
							) sub
							WHERE RowNum = @nID)
			set @nExist = ((select count(*) from @tmpTable where IdSubject = @idTmp))
		end

		insert into @tmpTable
		values (@idTmp)
		-- increase the counter
		set @nCnt = @nCnt + 1
	end

	-- this select return data
	
	insert into @rtnTable
	select IdSubject from @tmpTable as tbl
	order by tbl.IdSubject
	return
end


select *
from dbo.fn_Select_AtLeast03_SubjectIds('DEPT.02', 'STI.1')
order by IdSubject

select *

drop function dbo.fn_Select_AtLeast03_SubjectIds;

alter table Enrollments
drop column StudNumber

alter table Enrollments
drop column IdDept

alter table Enrollments
add idStudent nchar(20) not null

alter table Enrollments
add TaughtYear int not null

alter table Enrollments
add TaughtSemester int not null

alter table Enrollments
drop column TaughtSemester

alter table Enrollments
add GradePoint real not null
