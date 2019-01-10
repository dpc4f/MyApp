select * from dbo.Genders;


insert into Genders
values ('Male');

insert into Genders
values ('Female');

insert into Genders
value ('GEND.3', 'Not specified');


drop table Genders;

create table Genders
(
	IdGender int IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	Gender nvarchar(50)
)

select *
from Genders;