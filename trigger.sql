DELIMITER ##

CREATE TRIGGER after_student_result_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
    IF OLD.result <> NEW.result THEN
        INSERT INTO student_result_changes_log(name, old_result, new_result) VALUES
        (OLD.name, OLD.result, NEW.result);
    END IF;
END ##
DELIMITER ;


update students
set result = 85
where result = 69;

select * from student_result_changes_log;

DELIMITER ##

CREATE TRIGGER before_student_result_validation
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    SET NEW.name = upper(NEW.name);
    IF NEW.result < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A pontszam erteke nem lehet negativ!';
    END IF;
END ##

DELIMITER ;

INSERT INTO students (name, phone, result, born) VALUES
('Mirmong Marsr', '06-30123 4501', 30, '2003-04-05');

SELECT trigger_name 
FROM information_schema.triggers;

telefonyszam ellenorzo


DROP TRIGGER IF EXISTS before_phone_format_validation;
DELIMITER ##

CREATE TRIGGER before_phone_format_validation
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    IF NEW.phone IS NOT NULL  AND NEW.phone <> "" THEN
    -- felesleges karakterek eltávolítása
    SET NEW.phone = REPLACE(REPLACE(REPLACE(REPLACE(NEW.phone, ' ', ''), '-', ''), '(', ''), ')', '');

    -- egységes +36 formátumra
    IF NEW.phone LIKE '06%' THEN
        SET NEW.phone = CONCAT('+36', SUBSTRING(NEW.phone, 3));
    ELSEIF NEW.phone LIKE '0036%' THEN
        SET NEW.phone = CONCAT('+36', SUBSTRING(NEW.phone, 5));
    ELSEIF NEW.phone LIKE '36%' AND NEW.phone NOT LIKE '+%' THEN
        SET NEW.phone = CONCAT('+', NEW.phone);
    END IF;

    -- formazas
    IF CHAR_LENGTH(NEW.phone) = 12 AND NEW.phone LIKE '+36%' THEN
        -- +36 30 123 4567
        SET NEW.phone = CONCAT(
            SUBSTRING(NEW.phone, 1, 3), ' ',
            SUBSTRING(NEW.phone, 4, 2), ' ',
            SUBSTRING(NEW.phone, 6, 3), ' ',
            SUBSTRING(NEW.phone, 9, 4)
        );
    ELSEIF CHAR_LENGTH(NEW.phone) = 11 AND NEW.phone LIKE '+361%' THEN
        -- +36 1 123 4567
        SET NEW.phone = CONCAT(
            SUBSTRING(NEW.phone, 1, 3), ' ',
            SUBSTRING(NEW.phone, 4, 1), ' ',
            SUBSTRING(NEW.phone, 5, 3), ' ',
            SUBSTRING(NEW.phone, 8, 4)
        );
    ELSEIF CHAR_LENGTH(NEW.phone) = 11 AND NEW.phone LIKE '+36%' THEN
        -- +36 52 123 456
        SET NEW.phone = CONCAT(
            SUBSTRING(NEW.phone, 1, 3), ' ',
            SUBSTRING(NEW.phone, 4, 2), ' ',
            SUBSTRING(NEW.phone, 6, 3), ' ',
            SUBSTRING(NEW.phone, 9, 3)
        );
    ELSE
        SET NEW.phone = NEW.phone;
    END IF;
    END IF;
END ##

DELIMITER ;



telefonyszam regex
REGEXP '^\+?[0-9 ]{8,18}$'

DELIMITER ##

CREATE TRIGGER before_phone_format_validation_regex
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    IF NEW.phone IS NOT NULL  AND NEW.phone <> "" THEN
        SET NEW.phone = REGEXP_REPLACE(NEW.phone, '[^[0-9]', '');
        IF NEW.phone LIKE '06%' AND LENGTH(NEW.phone) = 11 THEN
            SET NEW.phone = CONCAT('+36', SUBSTRING(NEW.phone, 3));
        END IF;
    END IF;
END ##

DELIMITER ;


DELIMITER ##

CREATE TRIGGER before_phone_format_spacing
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    DECLARE nums VARCHAR(20);
    DECLARE numsForm VARCHAR(20);

    IF NEW.phone IS NOT NULL AND NEW PHONE <> "" THEN
        SET NEW.phone = REGEXP_REPLACE(NEW.phone, '[^0-9]', '');
    IF NEW.phone LIKE '06%' THEN
        SET NEW.phone = CONCATE(
        ('+36',SUBSTRING( NEW.phone, 3)),
        )
    IF NEW.phone LIKE '36%' THEN
    IF NEW.phone LIKE '361%' AND THEN

    
    IF LENGTH(NEW.phone) = 11 AND NEW.phone LIKE '+36%' THEN
    SET nums_formatted = CONCAT(
        SUBSTRING(NEW.phone, 1, 3, ' ')
    )
END ##
DELIMITER ;