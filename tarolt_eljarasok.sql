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



pontok atlaga

delimiter ##

create procedure result_avg
    (out sResult decimal,
    out resultText varchar(20))
begin
    select avg(result) into sResult
    from students;
    if sResult < 50 then 
        set resultText = 'bukott';
    elseif sResult between 50 and 80 then 
        set resultText = 'atlagos';
    else 
        set resultText = 'kituno';
    end if;

end ##
    
delimiter ;

call result_avg(@sResult, @resultText);
select @sResult as result, @resultText as resultText;


delimiter ##
create procedure get_result(
    out text varchar(20)
)
begin
    INSERT INTO student_result_varchar(name, result, @text) VALUES
        (OLD.name, OLD.result, @text);
end##
delimiter ;




delimiter ##
create procedure student_status(
    out sStatus varchar(20)
)
begin
    declare avgScore double default 0;
    select avg(result) into avgScore from students;
    
    case 
    when avgScore < 50 then
    set sStatus = "rossz";

    when avgScore between 50 and 80 then
    set sStatus = "kozepes";

    when avgScore > 80 then
    set sStatus = "kivalo";

    end case;

end ##
delimiter ;

call student_status(@status);
select @status;

delimiter ##
create procedure allStudentStatus()
begin
    select name, result, case
    when result < 50 then "rossz"
    when result between 50 and 80 then "atlagos"
    when result > 80 then "kivalo"
    else "nincs ilyen. -.-"
    end as sStatus
    from students;
end ##
delimiter ;

-- ket alulvonas vagy mi a bubanat

call allStudentStatus();


-- while feltétel do utasítas

delimiter ##

create procedure while_loop1()
begin
    declare x int;
    declare sValue char(10);
    set x = 1;
    set sValue = "";

    while x<=5 do
    set sValue = concat(sValue, x, ", ");
    set x = x + 1;
    end while;

    select sValue;

end ##
delimiter ;


--repeat utasítasok until feltétel end repeat

delimiter ##

create or replace procedure do_while_loop()
begin
    declare x int default 1;
    declare sValue varchar(50) default "";

    repeat 
    set sValue = concat(sValue, x, ", ");
    set x = x + 1;
    until x > 10
    end repeat;

    select sValue;

end ##
delimiter ;