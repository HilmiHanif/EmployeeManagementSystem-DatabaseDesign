-- FUNCTION
-- FUNCTIONS FORMAT EMAIL
CREATE FUNCTION func_email_format (@email VARCHAR(25))
RETURNS INT
AS
BEGIN
    DECLARE @result INT;
    
    -- Memeriksa input sesuai format email
    IF @email LIKE '%_@_%._%' AND @email NOT LIKE '%[^a-zA-Z0-9._@-]%'
        SET @result = 1;
    ELSE
        SET @result = 2;
    
    RETURN @result;
END;

-- Menguji fungsi dengan email yang benar
SELECT dbo.func_email_format('hilmi@gmail.com') AS IsValidEmail; -- true

-- Menguji fungsi dengan email yang salah
SELECT dbo.func_email_format('invalid-email') AS IsValidEmail; -- false



-- FUNCTIONS FORMAT GENDER "MALE" OR "FEMALE"
CREATE FUNCTION func_gender (@gender VARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @result INT;
    
    -- Memeriksa input "Male" atau "Female"
    IF @gender = 'Male' OR @gender = 'Female'
        SET @result = 1;
    ELSE
        SET @result = 2;
    
    RETURN @result;
END;

-- Menguji fungsi dengan gender "Male"
SELECT dbo.func_gender('Male') AS IsValidGender; -- true

-- Menguji fungsi dengan gender "Female"
SELECT dbo.func_gender('Female') AS IsValidGender; -- true

-- Menguji fungsi dengan gender yang salah
SELECT dbo.func_gender('Unknown') AS IsValidGender; -- false



-- FUNCTIONS FORMAT PHONE NUMBER
CREATE FUNCTION func_phone_number (@phone VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @result INT;

    -- Memeriksa input hanya angka
    IF @phone NOT LIKE '%[^0-9]%'
        SET @result = 1;
    ELSE
        SET @result = 2;
    
    RETURN @result;
END;

-- Menguji fungsi dengan nomor telepon yang benar
SELECT dbo.func_phone_number('08884142475') AS IsValidPhoneNumber; -- true

-- Menguji fungsi dengan nomor telepon yang salah
SELECT dbo.func_phone_number('099dssdshdh') AS IsValidPhoneNumber; -- false

-- Menguji fungsi dengan nomor telepon yang salah
SELECT dbo.func_phone_number('hdjshdjds') AS IsValidPhoneNumber; -- false


-- FUNCTIONS SALARY
CREATE FUNCTION func_salary (@id_job VARCHAR(10), @salary INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;

    -- Memeriksa salary berada dalam rentang min_salary dan max_salary berdasarkan id_job
    IF EXISTS (
        SELECT 1
        FROM tbl_jobs
        WHERE id_job = @id_job AND @salary >= min_salary AND @salary <= max_salary
    )
        SET @result = 1;
    ELSE
        SET @result = 2;
    
    RETURN @result;
END;


-- sebelumnya saya sudah memasukan id, min, max salary ditable job
-- Menguji fungsi dengan salary yang sesuai
SELECT dbo.func_salary('JOBS001', 3500000) AS IsValidSalary; -- true

-- tidak valid karena melebihi max salary
-- Menguji fungsi dengan salary yang kurang dari min_salary
SELECT dbo.func_salary('JOBS002', 10000000) AS IsValidSalary; -- false


CREATE FUNCTION func_password_policy (@password VARCHAR(255))
RETURNS INT
AS
BEGIN
    DECLARE @isValid INT = 1;

    -- Memeriksa panjang password
    IF LEN(@password) < 8
    BEGIN
        SET @isValid = 2; 
    END
    ELSE
    BEGIN
        -- Memeriksa minimal 1 huruf besar
        IF @password NOT LIKE '%[A-Z]%'
        BEGIN
            SET @isValid = 2; 
        END
        -- Memeriksa minimal 1 huruf kecil
        ELSE IF @password NOT LIKE '%[a-z]%'
        BEGIN
            SET @isValid = 2; 
        END
        -- Memeriksa minimal 1 angka
        ELSE IF @password NOT LIKE '%[0-9]%'
        BEGIN
            SET @isValid = 2; 
        END
        -- Memeriksa minimal 1 simbol
        ELSE IF @password NOT LIKE '%[^a-zA-Z0-9]%'
        BEGIN
            SET @isValid = 2; 
        END
    END

    RETURN @isValid;
END;


SELECT dbo.func_password_policy('HilmiHanif123!') AS IsValid; -- true


SELECT dbo.func_password_policy('hilmihanif123') AS IsValid; -- false


SELECT * FROM tbl_accounts;






