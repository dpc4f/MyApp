alter table Departments
add DeptNumb int not null
go

exec sp_rename StdTitle, StdTitles
go

insert into Departments
values ('DEPT.01', 'Vat Ly Dia Cau', 1);

insert into Departments
values ('DEPT.02', 'Vat Ly Khong Gian', 2);

insert into Departments
values ('DEPT.03', 'Toan Vat Ly', 3);

insert into Departments
values ('DEPT.04', 'Vat Ly Luong Tu', 4);

insert into Departments
values ('DEPT.05', 'Cong Nghe Nang Luong', 5);

insert into Departments
values ('DEPT.06', 'Vat Ly Vat Chat', 6);

insert into Departments
values ('DEPT.07', 'Khoa Hoc May Tinh', 7);

insert into Departments
values ('DEPT.08', 'TRI TUE NHAN TAO', 8);

insert into Departments
values ('DEPT.09', 'Cong Nghe Phan Mem', 9);

insert into Departments
values ('DEPT.10', 'He Thong Thong Tin', 10);

insert into Departments
values ('DEPT.11', 'Toan Va Cau Truc Du Lieu & Thuat Toan', 11);

insert into Departments
values ('DEPT.12', 'He Thong Nhung', 12);

insert into Departments
values ('DEPT.13', 'Ngon Ngu Lap Trinh', 13);

insert into Departments
values ('DEPT.14', 'Co So Du Lieu', 14);

insert into Departments
values ('DEPT.15', 'Mang Luoi Da Thiet Bi', 15);

insert into Departments
values ('DEPT.16', 'Vien Thong Thong Tin', 16);

insert into Departments
values ('DEPT.17', 'Thong Tin Ung Dung', 17);



UPDATE Departments
SET IdDept = RTRIM(LTRIM(IdDept))


drop table Departments;
create table Departments (
	IdDept INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	DeptName nvarchar(50)
)


insert into Departments
values ('Vat Ly Dia Cau');

insert into Departments
values ('Vat Ly Khong Gian');

insert into Departments
values ('Toan Vat Ly');

insert into Departments
values ('Vat Ly Luong Tu');

insert into Departments
values ('Cong Nghe Nang Luong');

insert into Departments
values ('Vat Ly Vat Chat');

insert into Departments
values ('Khoa Hoc May Tinh');

insert into Departments
values ('TRI TUE NHAN TAO');

insert into Departments
values ('Cong Nghe Phan Mem');

insert into Departments
values ('He Thong Thong Tin');

insert into Departments
values ('Toan Va Cau Truc Du Lieu & Thuat Toan');

insert into Departments
values ('He Thong Nhung');

insert into Departments
values ('Ngon Ngu Lap Trinh');

insert into Departments
values ('Co So Du Lieu');

insert into Departments
values ('Mang Luoi Da Thiet Bi');

insert into Departments
values ('Vien Thong Thong Tin');

insert into Departments
values ('Thong Tin Ung Dung');

