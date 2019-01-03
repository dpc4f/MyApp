insert into stmgt.genders
values(1, 'Male');

insert into stmgt.genders
values(2, 'Female');

insert into stmgt.genders
values(3, 'Other');

select *
from stmgt.genders;

delimiter //
create procedure `stmgt`.`ReadStudent` (IN st_sex VARCHAR(45) )
begin
    select * from `stmgt`.students
    where sex = st_sex;
end //
delimiter ;

call stmgt.ReadStudent('male');

delimiter //
drop procedure if exists stmgt.CreateDepartmentData //
create procedure `stmgt`.`CreateDepartmentData` ()
begin
	declare id int;
    declare dept varchar(45);
    
    set id = 1;
    while id <= 30 do
		set dept = CONCAT('DEPT ', id);
        insert into stmgt.departments
        values (id, dept);
        
        set id = id + 1;
	end while;
end //
delimiter ;
call stmgt.createdepartmentddepartmentsata();

delimiter //
drop procedure if exists stmgt.DeleteDepartmentData //
create procedure stmgt.DeleteDepartmentData ()
begin
	delete from stmgt.Departments;
end //
delimiter ;
call stmgt.deletedepartmentdata();
    


delimiter //
drop procedure if exists stmgt.CreateStudentData //
create procedure `stmgt`.`CreateStudentData` (IN idDept INT)
begin
	declare id int;
    declare tmp char;
    declare fn varchar(45);
    declare ln varchar(45);
    declare md varchar(45);
    
    set id = 1;
	while id <= 1500 do
        set fn = CONCAT('FirstName', id);
        set ln = CONCAT('LastName', id);
        set md = CONCAT('Middle', id);
		
        insert into stmgt.students
        values (id, fn, ln, md, 'Male', idDept);
        
        set id = id + 1;
    end while;
end //
delimiter ;

call stmgt.CreateStudentData(1);

select * from stmgt.students;
select * from stmgt.departments;


select * from stmgt.departments;
insert into stmgt.departments
value (1, 'CNTT');


delimiter //
drop procedure if exists stmgt.DeleteStudentData //
create procedure stmgt.DeleteStudentData(IN idDept INT)
begin
	delete from stmgt.Students
    where idDepartment = idDept;
end //
delimiter ;

call stmgt.DeleteStudentData(1);


