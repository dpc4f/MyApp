select * from StdTitles;

insert into StdTitles
values ('STI.1', 'Freshman', 1);

insert into StdTitles
values ('STI.2', 'Sophomore', 2);

insert into StdTitles
values ('STI.3', 'Junior', 3);

insert into StdTitles
values ('STI.4', 'Senior', 4);

insert into StdTitles
values ('STI.5', 'Senior L1', 5);

insert into StdTitles
values ('STI.6', 'Senior L2', 6);

delete StdTitles
where YearNumb = 4

drop table StdTitles
create table StdTitles
(TitleNo INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED, 
StudentTitle nvarchar(50))

insert into StdTitles
values ('Freshman');

insert into StdTitles
values ('Sophomore');

insert into StdTitles
values ('Junior');

insert into StdTitles
values ('Senior');

insert into StdTitles
values ('Senior L1');

insert into StdTitles
values ('Senior L2');

select * from StdTitles;