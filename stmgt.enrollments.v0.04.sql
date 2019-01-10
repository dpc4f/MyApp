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
create procedure sp_GenerateEnrollData 
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
	declare @MAX_STUDENT_NUMBER int
	set @MAX_STUDENT_NUMBER = (select max(StudentNo)from dbo.Students)
	print @MAX_STUDENT_NUMBER

	declare @nStudNumber int
	set @nStudNumber = 1
	while (@nStudNumber <= @MAX_STUDENT_NUMBER)
	begin
		-- get deptId of the student
		declare @idDept nchar(10)
		--set @idDept = (select Students.IdDept
		--				from Students
		--				where @nStudNumber = IdStudent)
		set @idDept = (select IdDept from Students where @nStudNumber = StudentNo)
		-- get 2 last digits of current year
		declare @nCurYear int 
		select @nCurYear = dbo.fn_getCurrentYear()

		-- get the student's ID
		declare @idStudent as nchar(20)
		-- set @idStudent = (select IdStudent 
		--					from Students
		--					where IdStudent = @nStudNumber)
		-- set @idStudent = @nStudNumber
		-- print @idStudent

		-- get the entrance year of the student
		declare @entranceYearStr as varchar(50)
		declare @nEntrYear int
		-- set @entranceYearStr = (SELECT tempo FROM (
		--							SELECT ROW_NUMBER () OVER (ORDER BY nRow) AS RowNum, tempo
		--							FROM dbo.fn_splitstring(@idStudent) 
		--						) sub
		--						WHERE RowNum = 2)
		-- set @nEntrYear = cast(@entranceYearStr as int)
		set @nEntrYear = (select EntranceYear from Students where @idStudent = StudentNo)
		print @nEntrYear

		declare @nCountStudYear int
		set @nCountStudYear = 1
		while (@nCountStudYear <= @nCurYear - @nEntrYear)
		begin
			-- get the student title id
			declare @studTitleId as nchar(10)
			set @studTitleId = dbo.fn_GetStudentTitleId (@nCountStudYear) 
			-- print ('Student title id:' + @studTitleId)

			-- get the subjects of the students with @studTitleId
			declare @subjectTbl table (nRow int, IdSubject nchar(20), SubjectNumber int)
			delete @subjectTbl
			insert into @subjectTbl
			select *
			from dbo.fn_Select_AtLeast03_SubjectIds(@idDept, @studTitleId)

			-- for each subject, make an enrollment of the student
			declare @nSbjTotal as int
			set @nSbjTotal = (select count(*) from @subjectTbl)
			-- print 'Total subject count: ' + cast(@nSbjTotal as nvarchar(50))

			declare @nCount as int
			set @nCount = 1
			declare @nSbjNumber as int
			declare @idSubject as nchar(20)

			while (@nCount <= @nSbjTotal)
			begin
				-- generate a random grade point
				declare @nGradePoint int
				set @nGradePoint = dbo.fn_Random(6) -- [0..5]
				-- print 'Grade point: ' + cast(@nGradePoint as nvarchar(50))

				-- taught year is the entrance year + @nCountStudYear - 1
				declare @nTaughtYear int
				set @nTaughtYear = @nEntrYear + @nCountStudYear - 1
				-- taught semester : TO BE CONTINUED, just filled the value 1

				-- get the subject number
				-- set @nSbjNumber= (Select SubjectNumber
				--					FROM (
				--							SELECT ROW_NUMBER () OVER (ORDER BY nRow) AS RowNum, *
				--							FROM  @subjectTbl
				--						) sub
				--					WHERE RowNum = @nCount)
				-- print 'Subject number: ' + cast(@nSbjNumber as nvarchar(50))

				-- get the subject id
				set @idSubject = @nCount
				-- print 'Subject id: ' + @idSubject
		

				-- create enrollment id
				-- ENRO.<SubjectNumber>.<StudentNumber>.<TaughtYear>
				-- declare @idEnrollment as varchar(50)
				-- set @idEnrollment = 'ENRO.' + dbo.fn_ZeroPad(@nSbjNumber, 4) + '.' 
				--							+ dbo.fn_ZeroPad(@nStudNumber, 6) + '.' + cast(@nTaughtYear as nvarchar(50))
				-- print @idEnrollment

				-- insert into enrollments table
				insert into dbo.Enrollments
				values (@nSbjNumber, @nStudNumber, @nTaughtYear, @nGradePoint)
	
				-- increase the counter
				set @nCount = @nCount + 1
			end
			-- increase the counter
			set @nCountStudYear = @nCountStudYear + 1
		end
		-- increase the counter
		set @nStudNumber = @nStudNumber + 1
	end
end


exec dbo.sp_GenerateEnrollData;

select * from dbo.Enrollments;
select * from dbo.Subjects;

drop procedure dbo.sp_GenerateEnrollData

delete dbo.Enrollments

sp_helptext 'sp_GenerateEnrollData'

alter table dbo.Enrollments
alter column IdEnrollment nchar(30) not null
-- calculate subject numbers and return as a table
-- input IdDept, IdStudTitle

create function fn_GetListSubjectId (@idDept as int, @idStudTitle as int)
	returns @rtnTable table (IdSubject int not null)
  as
begin
	declare @tmpTable table (idSubject int)
	
	insert into @tmpTable
	select IdSubject
	from Subjects 
	where IdDept = @idDept and IdStudentTitle = @idStudTitle

	-- this select return data
	insert into @rtnTable
	select IdSubject 
	from @tmpTable
	order by IdSubject
	return
end

drop function dbo.fn_GetListSubjectId

select *
from dbo.fn_GetListSubjectId(5, 2)

select * from Subjects

create function fn_GetStudentTitleId(@nStudYear as int)
	returns nchar(10)
  as
begin
	declare @studTitleId nchar(10)
	set @studTitleId = (select IdTitle 
						from dbo.StdTitles 
						where @nStudYear = YearNumb)
	return @studTitleId
end
select dbo.fn_GetStudentTitleId(5)

-- have to sorted the returned table if necessary
create function fn_Select_AtLeast03_SubjectIds (@idDept as int, @idStudTitle as int)
	returns @rtnTable table( IdSubject int not null )
  as
begin
	declare @tmpTable table (IdSubject int not null)
	declare @sbjIdTable table (IdSubject int)
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
	declare @sbjNumbTmp int

	set @nCnt = 1
	while @nCnt <= @nSlot
	begin
		set @nExist = 1

		while (@nExist != 0)
		begin
			set @nID = dbo.fn_Random(7) -- [0..6]
			set @nID = @nID + 1 -- [1..7]
			-- SELECT @idTmp = IdSubject, @sbjNumbTmp = SubjectNumber 
			--				FROM (
			--					SELECT ROW_NUMBER () OVER (ORDER BY IdSubject) AS RowNum, *
			--					FROM @sbjIdTable
			--				) sub
			--				WHERE RowNum = @nID
			set @nExist = ((select count(*) from @tmpTable where IdSubject = @nID))
		end

		insert into @tmpTable
		values (@nID)
		-- increase the counter
		set @nCnt = @nCnt + 1
	end

	-- this select return data
	
	insert into @rtnTable
	select * from @tmpTable as tbl
	order by tbl.IdSubject
	return
end


select *
from dbo.fn_Select_AtLeast03_SubjectIds(4, 2)

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


drop table Enrollments
create table Enrollments
(
	IdEnroll  INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	IdSubject int,
	IdStudent int,
	TaughtYear int,
	GradePoint real
)

select * 
from Enrollments;


select max(StudentNo)from dbo.Students
select * from Students