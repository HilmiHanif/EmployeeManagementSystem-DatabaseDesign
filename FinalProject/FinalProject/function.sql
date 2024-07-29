-- FUNCTION GENDER
CREATE FUNCTION dbo.func_gender
(
    @gender VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;
    
    -- Memeriksa apakah @Gender adalah 'Male' atau 'Female'
    IF @gender = 'Male' OR @gender = 'Female'
        SET @result = 1; -- Valid
    ELSE
        SET @result = 0; -- Tidak valid
    
    RETURN @result;
END;

-- FUNCTION EMAIL
CREATE FUNCTION dbo.func_email_format
(
    @email VARCHAR(25)
)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;
    
    -- Memeriksa apakah @Email mengandung '@gmail.com' di akhir
    IF CHARINDEX('@gmail.com', @email) = LEN(@email) - LEN('@gmail.com') + 1
        SET @result = 1; -- Valid
    ELSE
        SET @result = 0; -- Tidak valid
    
    RETURN @result;
END;

-- TESTING
SELECT dbo.func_email_format('hilmi@gmail.com') AS IsValidEmail; -- true
SELECT dbo.func_email_format('invalid-email') AS IsValidEmail; -- false


-- FUNCTION PHONE NUMBER
CREATE FUNCTION dbo.func_phone_number
(
    @phone VARCHAR(20)
)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;
    
    -- Memeriksa apakah @Phone hanya berisi digit
    IF @phone LIKE '%[^0-9]%'
        SET @result = 0; -- Tidak valid
    ELSE
        SET @result = 1; -- Valid
    
    RETURN @result;
END;


-- TESTING
SELECT dbo.func_phone_number('08884142475') AS IsValidPhoneNumber; -- true
SELECT dbo.func_phone_number('099dssdshdh') AS IsValidPhoneNumber; -- false
SELECT dbo.func_phone_number('hdjshdjds') AS IsValidPhoneNumber; -- false


-- FUNCTION SALARY
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
        SET @result = 0;
    
    RETURN @result;
END;

-- TESTING
SELECT dbo.func_salary('JOBS001', 3500000) AS IsValidSalary; -- true
SELECT dbo.func_salary('JOBS002', 10000000) AS IsValidSalary; -- false


-- PASWORD POLICY
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



-- TESTING
SELECT dbo.func_password_policy('HilmiHanif123!') AS IsValid; -- true
SELECT dbo.func_password_policy('hilmihanif123') AS IsValid; -- false







