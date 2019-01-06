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

drop function dbo.fn_Random

select dbo.fn_Random(19);


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

declare @entranceYearStr as varchar(50)
set @entranceYearStr = ()
select @entranceYearStr

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


