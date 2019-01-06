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
