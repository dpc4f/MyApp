Select Rand() As RandomNumber, 
		NewId() As GUID, 
		Abs(Checksum(NewId())) % 15 As RandomInteger;

select Abs(Checksum(NewId())) % 15;

create view getNewID as select newid() as new_id;
go

create function fn_newid ()
returns uniqueidentifier
as begin
   return (select new_id from getNewID)
end;
go

declare @num as int
select dbo.fn_newid()
go

/*
	generate random number in 0..nBase-1, inclusive
*/
create function fn_Random (@nBase int)
	returns int
 as
begin
	declare @number int
	set @number = 1

	set @number = Abs(Checksum(dbo.fn_newid())) % @nBase;

	RETURN @number
end;
go

drop function dbo.fn_Random;
go

select dbo.fn_Random(19);
go

/*
	@yourNum: the number
	@wid: the zeros, including the number
*/
create function fn_ZeroPad (@yourNum int, @wid int)
	returns varchar(50) as 
begin
	declare @str varchar(50)
	set @str = right((100000 + @yourNum), @wid)
	
	return @str
end;

drop function dbo.fn_ZeroPad;
go

CREATE FUNCTION dbo.fn_splitstring ( @stringToSplit VARCHAR(MAX) )
RETURNS
 @returnList TABLE (nRow int, tempo nvarchar(50))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT
 declare @nRow int
 set @nRow = 1


 WHILE CHARINDEX('.', @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX('.', @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @nRow, @name
  set @nRow = @nRow + 1

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @nRow, @stringToSplit

 RETURN
END

drop function fn_splitstring

SELECT * FROM dbo.fn_splitstring('STUD.15.01.100002')

use stmgtdb;
go

create function fn_getCurrentYear()
	returns int
  as
begin
	--declare @curYear nchar(2)
	--set @curYear = dbo.fn_ZeroPad((YEAR(GetDAtE()) % 100), 2)

	return YEAR(GetDAtE()) % 100
end

select dbo.fn_getCurrentYear()
drop function dbo.fn_getCurrentYear;

declare @entranceYearStr as varchar(50)
set @entranceYearStr = ()
select @entranceYearStr
go

SELECT tempo FROM
(
	SELECT
		ROW_NUMBER () OVER (ORDER BY nRow) AS RowNum, tempo
		FROM
		dbo.fn_splitstring('STUD.15.01.100002') 
) sub
WHERE RowNum = 2

	SELECT
		ROW_NUMBER () OVER () AS EntranceYear, tempo
		FROM
		dbo.fn_splitstring('STUD.15.01.100002') 


select max(StudNumber)from dbo.Students;


create function fn_calculateGPA( @idStudent nchar(20) )
	returns real
  as
begin
	declare @rlGPA real

	-- query list of enrollments based on student id
	declare @enrollTbl table ( IdStudent nchar(20), IdSubject nchar(20), GradePoint real )
	insert into @enrollTbl
	select IdStudent, IdSubject, GradePoint
	from Enrollments
	where @idStudent = IdStudent

	declare @nTotalRow int
	set @nTotalRow = (select count(*) from @enrollTbl)
	declare @rlTotalPoint real
	set @rlTotalPoint = (select sum(GradePoint) from @enrollTbl)

	return (@rlTotalPoint / @nTotalRow)
end

drop function fn_calculateGPA;

select dbo.fn_calculateGPA( 'STUD.15.01.100007' )
go

create function fn_calculateStudyingYears( @idStudent nchar(20) )
	returns int
  as
begin
	-- get 2 last digits of current year
	declare @nCurYear int 
	select @nCurYear = dbo.fn_getCurrentYear()

	-- get the entrance year of the student
	declare @entranceYearStr as varchar(50)
	declare @nEntrYear int
	set @entranceYearStr = (SELECT tempo FROM (
								SELECT ROW_NUMBER () OVER (ORDER BY nRow) AS RowNum, tempo
								FROM dbo.fn_splitstring(@idStudent) 
							) sub
							WHERE RowNum = 2)
	set @nEntrYear = cast(@entranceYearStr as int)

	return @nCurYear - @nEntrYear 
end


select dbo.fn_calculateStudyingYears( 'STUD.15.01.100002' )

select dbo.fn_calculateStudyingYears( 'STUD.15.01.100002' )

go

create function fn_calculateTotalCredits( @idStudent nchar(20) )
	returns int
  as
begin
	declare @subjectTbl table ( IdSubject nchar(20), Credits int )
	insert into @subjectTbl
	select s.IdSubject, s.Credits
	from Subjects s, Enrollments e
	where @idStudent = e.IdStudent and e.IdSubject = s.IdSubject

	return (select sum(Credits) from @subjectTbl)
end

select dbo.fn_calculateTotalCredits( 'STUD.15.01.100007' )

go

-- Result:	2: Passed, when nTotalCredit >= 55 and rlGPA >= 2.50
--			3: Failed, when nStudyingYear > 6 and (nTotalCredit < 55 or rlGPA < 2.50)
--			1: On-going, when nStudyingYear <= 6
create function fn_getCourseResult( @studentNo int )
	returns @rtnRetTable (IdStudent nchar(20), nStudyingYear int, nTotalCredit int, rlGPA real, nPassed int)
  as
begin
	declare @tmpTbl (IdStudent nchar(20), nStudyingYear int, nTotalCredit int, rlGPA real, nPassed int)
	-- query student id
	declare @idStudent nchar(20)
	set @idStudent = (select IdStudent from Students where @studentNo = StudNumber)

	-- calculate numbers of studying years
	declare @nStudyingYear int
	set @nStudyingYear = dbo.fn_calculateStudyingYears( @idStudent )

	-- calculate total credits the student has rolled in
	declare @nTotalCredit int
	set @nTotalCredit = dbo.fn_calculateTotalCredits( @idStudent )

	-- calculate grade point average (GPA)
	declare @rlGPA real
	set @rlGPA = dbo.fn_calculateGPA( @idStudent )

	declare @nCouseResult int
	if ( @nTotalCredit >= 55 and @rlGPA >= 2.50 )
	begin
		set @nCouseResult = 2
	end
	else if ( @nStudyingYear <= 6 )
	begin
		set @nCouseResult = 1
	end
	else if ( @nStudyingYear > 6 and (@nTotalCredit < 55 or @rlGPA < 2.50) )
	begin
		set @nCouseResult = 3
	end

	insert into @r
end

go




