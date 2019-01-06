-- will improve if there's time
create procedure sp_GenerateSubjectData  as
begin
	declare @MAX_YEAR int
	set @MAX_YEAR = 4
	declare @MAX_DEPT int
	set @MAX_DEPT = 17
	declare @MAX_SUBJ_PER_YEAR int
	set @MAX_SUBJ_PER_YEAR = 7
	
	
	-- generate the id
	declare @idSubject varchar(50)
	declare @nYear int -- correspondent to students' year
	set @nYear = 1
	declare @nDept int	
	set @nDept = 1
	declare @nSubj int
	set @nSubj = 1
	declare @nSubjYear int	-- number of subjects per year
	set @nSubjYear = 1
	
	while (@nYear <= @MAX_YEAR)
	begin
		set @nDept = 1
		while (@nDept <= @MAX_DEPT)
		begin
			set @nSubjYear = 1
			while (@nSubjYear <= @MAX_SUBJ_PER_YEAR)
			begin
				set @idSubject = 'SUBJ.' + cast(@nYear as varchar(50)) + '.' + 
									dbo.fn_ZeroPad(@nDept, 2) + '.' + dbo.fn_ZeroPad(@nSubj, 4)
				print @idSubject
				
				-- generate the credits
				declare @nCredit int
				set @nCredit = dbo.fn_Random(3) -- [0..2]
				set @nCredit = @nCredit + 2 -- [2..4]
				print @nCredit

				-- query idDept
				declare @idDept varchar(50)
				set @idDept = (select IdDept from dbo.Departments where @nDept = DeptNumb)
				print @idDept

				-- query idStdTitle
				declare @idStdtitle varchar(50)
				set @idStdtitle = (select IdTitle from dbo.StdTitles where @nYear = YearNumb)
				print @idStdTitle

				-- add to the table
				insert into dbo.Subjects
				values (@idSubject, 'Subject Name', @nCredit, @idDept, @idStdtitle, @nSubj)

				-- update counters				
				set @nSubj = @nSubj + 1
				set @nSubjYear = @nSubjYear + 1
			end
			set @nDept = @nDept + 1
		end
		set @nYear = @nYear + 1
	end
end

drop procedure dbo.sp_GenerateSubjectData;

exec dbo.sp_GenerateSubjectData;


delete Subjects;

select * from Subjects;

insert into Subjects
values ('SUBJ.01.07.0045', 'subject forty-five', 4, 'DEPT.07', 'STI.1');

select DeptNumb
from Departments

-- query idDept
declare @idDept varchar(50)
set @idDept = (select IdDept from dbo.Departments where 1 = DeptNumb)
print @idDept


select dbo.fn_ZeroPad(13, 3)

delete Subjects;

exec sp_rename 'Subjects.IdSubjects', 'IdSubject', 'COLUMN';

alter table dbo.Subjects
add SubjectNumber int null


