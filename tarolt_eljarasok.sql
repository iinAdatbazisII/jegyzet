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

select @student_name as Név;



fogad: pont ertek
visszaad: nev

delimiter ##
create procedure show_student_by_result(
    in student_result int,
    out student_name varchar(50)
)
begin
    select name into student_name from students where result = student_result
    limit 1;
end ##
delimiter ;

set @student_result = 82;
call show_student_by_result(@student_result, @student_name);
select @student_name;



delimiter ##
create procedure get_result(
    out failed int,
    out five int,
    out average int
)
begin
    select count(id) into failed from students where result < 50;
    select count(id) into five from students where result > 80;
    select floor(avg(result)) into average from students;
end##
delimiter ;

call get_result(@fail, @pass, @avg)

select @fail as Bukott, @pass as Kituno, @avg as Atlag;

in nev
pontszam ->> 50 bukott 50-80 atlagos 80 kituno

delimiter ##
create procedure (
    in student_name varchar(50)
    out score_str varchar(20)
)
begin
    select score from students where name = student_name
end##
delimiter ;



90 folotti pontszam

delimiter ##
create procedure get_passplus(
    out plus_name varchar(50)
)
begin
    select name into plus_name from students where result > 90

end##
delimiter ;

call get_passplus(@plus_name);
select @plus_name;


bukottak +5 pont

pontszam alapjan megbukott atlagos kituno

delimiter ##
create procedure get_student_level(
    in student_id int,
    out student_level varchar(20)
)
begin
    declare sResult int;
    select result into sResult from students where id = student_id;
    set student_level = case 
        when sResult < 50 then 'fail'
        when sResult between 50 and 80 then 'average'
        when sResult > 80 then 'excellent'
    end;
end##
delimiter ;


delimiter ##

create procedure get_student_level2(
    in student_id int,
    out student_result varchar(20)
)
begin
    declare sResult int;
    
    select result into sResult from students where id = student_id;
    
    if sResult < 50 then 
        set student_result = 'bukott';
    elseif sResult between 50 and 80 then 
        set student_result = 'atlagos';
    else 
        set student_result = 'kituno';
    end if;
end##

delimiter ;

call get_student_level2(3, @student_result);
select @student_result as 'eredmeny';

delimiter ##
create procedure last_resort()
begin
    update students
    set result = result + 5
    where result < 50;

end##
delimiter ;
