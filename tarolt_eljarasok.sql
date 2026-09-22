delimiter ##
create procedure nev(parameterek)
    begin
        --utasitas
    end ##
    
delimiter ;

delimiter ##
create procedure show_students()
    begin
        select * from students;
    end ##
    
delimiter ;

call show_students();

listazas
show procedure status;

szebb listazas:
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_type = 'PROCEDURE';

delimiter ##
create procedure show_student(
    in student_id int
)
    begin
        select name from students where id = student_id;
    end##
delimiter ;

call show_student(3);

delimiter ##
create procedure show_student_phone(
    in student_id int
)
    begin
        select name,phone from students where id = student_id;
    end##
delimiter ;

delimiter ##
create procedure show_student_by_phone(
    in phone_no varchar(50) default "1234567"
)
    begin
        select name,phone from students where phone = phone_no;
    end##
delimiter ;

call show_student_by_phone("+36 70 990 1278")

delimiter ##
create procedure show_student_by_phone2(
    in phone_no varchar(50),
    out student_name varchar(50)
)
    begin
        select name into student_name from students where phone = phone_no;
    end##
delimiter ;

set @phone = "+36 70 990 1278";

call show_student_by_phone(@phone, @student_name);

select @student_name;