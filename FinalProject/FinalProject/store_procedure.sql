-- STORE PROCEDURE ADD DATA REGIONS - DEPARTMENT 

-- ADD REGIONS
CREATE PROCEDURE insert_regions
   @id_region int,
   @name VARCHAR(25)
AS   
BEGIN
	INSERT INTO tbl_regions(id_region, name)
	VALUES (@id_region, @name);
END;

EXEC insert_regions 1, 'Asia';
EXEC insert_regions 2, 'Africa';
EXEC insert_regions 3, 'Australia';
EXEC insert_regions 4, 'Europe';

EXEC insert_regions 5, 'TESTING REGION';

SELECT * FROM tbl_regions;

-- ADD COUNTRIES
CREATE PROCEDURE insert_countries
   @id_country CHAR(3),
   @name VARCHAR(40),
   @id_region INT
AS   
BEGIN
	INSERT INTO tbl_countries(id_country, name, id_region)
	VALUES (@id_country, @name, @id_region);
END;

EXEC insert_countries 'IDN', 'Indonesia', 1;
EXEC insert_countries 'MYS', 'Malaysia', 1;
EXEC insert_countries 'FRA', 'France', 4;
EXEC insert_countries 'ITA', 'Italy', 4;

EXEC insert_countries 'TST', 'TESTING COUNTRY', 5;

SELECT * FROM tbl_countries;


-- ADD LOCATIONS
CREATE PROCEDURE insert_locations
   	@id_location INT,
	@street_address VARCHAR(40),
	@postal_code VARCHAR(12),
	@city VARCHAR(30),
	@state_province VARCHAR(25),
	@id_country CHAR(3)
AS   
BEGIN
	INSERT INTO tbl_locations(id_location, street_address, postal_code, city, state_province, id_country)
	VALUES (@id_location, @street_address, @postal_code, @city, @state_province, @id_country);
END;

EXEC insert_locations 100, NULL, NULL, 'Semarang', 'Central Java', 'IDN';
EXEC insert_locations 110, NULL, NULL, 'Surabaya', 'East Java', 'IDN';
EXEC insert_locations 120, NULL, NULL, 'Bandung', 'West Java', 'IDN';


EXEC insert_locations 130, NULL, NULL, 'TESTING', 'TESTING', 'TST';

SELECT * FROM tbl_locations;

-- ADD DEPARTMENT
CREATE PROCEDURE insert_departments
	@id_department INT,	
	@name VARCHAR(30),
	@id_location INT 
AS   
BEGIN
	INSERT INTO tbl_departments(id_department, name, id_location)
	VALUES (@id_department, @name, @id_location);
END;

EXEC insert_departments 200, 'Finace', 100;
EXEC insert_departments 210, 'Marketing', 110;
EXEC insert_departments 220, 'Informatic Engineering', 120;

EXEC insert_departments 230, 'TESTING', 130;

SELECT * FROM tbl_departments;


-- ADD JOBS
CREATE PROCEDURE insert_jobs
	@id_job VARCHAR(10),	
	@tittle VARCHAR(30),
	@min_salary INT,
	@max_salary INT
AS   
BEGIN
	INSERT INTO tbl_jobs(id_job, title, min_salary, max_salary)
	VALUES (@id_job, @tittle, @min_salary, @max_salary);
END;

EXEC insert_jobs 'JOBS001', 'Front-End Web Developer', 3500000, 8000000;
EXEC insert_jobs 'JOBS002', 'Back-End Web Developer', 3500000, 8000000;
EXEC insert_jobs 'JOBS003', 'Database Administrator', 3000000, 7500000;


EXEC insert_jobs 'JOBS004', 'JOBS TESTING', 2500000, 7500000;

SELECT * FROM tbl_jobs;


-- ADD EMPLOYEES
CREATE PROCEDURE insert_employees
(
    @id_employee INT,	
	@firstname VARCHAR(25),
	@last_name VARCHAR(25),
	@gender VARCHAR(10),
	@email VARCHAR(25),
	@phone VARCHAR(20),
	@hire_date DATE,
	@salary INT, 
	@id_manager INT,
	@id_job VARCHAR(10),
	@id_department INT
)
AS
BEGIN
    DECLARE @IsValidGender INT,
            @IsValidEmail INT,
            @IsValidPhone INT,
            @IsValidSalary INT;
    -- Validasi 
    SET @IsValidGender = dbo.func_gender(@gender);
    SET @IsValidEmail = dbo.func_email_format(@email);
    SET @IsValidPhone = dbo.func_phone_number(@phone);
    SET @IsValidSalary = dbo.func_salary(@id_job, @salary);
    -- Cek validasi
    IF @IsValidGender = 1 AND @IsValidEmail = 1 AND @IsValidPhone = 1 AND @IsValidSalary = 1
    BEGIN
        -- tambahkan data 
		INSERT INTO tbl_employees	(id_employee, first_name, last_name, gender, email, phone, hire_date, salary,
								id_manager, id_job, id_department)
		VALUES	(@id_employee, @firstname, @last_name, @gender, @email, @phone, @hire_date, @salary, 
			@id_manager, @id_job, @id_department);
        PRINT 'Employee added successfully.';
    END
    ELSE
    BEGIN
        -- pesan error
        PRINT 'Error: Invalid input data. Please check your input and try again.';
    END
END;


EXEC insert_employees	300, 'Hilmi', 'Hanif', 'Male', 'hilmihanif@gmail.com', 
					'08884142475', '2024-06-05', 6000000, NULL, 'JOBS001', 220;

EXEC insert_employees	310, 'Muhammad', 'Burhanudin', 'Male', 'burhanudin@gmail.com', 
					'081312181504', '2024-06-05', 6000000, NULL, 'JOBS002', 220;

EXEC insert_employees	320, 'Desi', 'Noviyanti', 'Female', 'desinoviyanti@gmail.com', 
					'08219051840', '2024-06-05', 6000000, NULL, 'JOBS003', 220;

EXEC insert_employees	330, 'Paman', 'Sam', 'Male', 'pamanSam', 
					'08219051845', '2024-07-05', 6000000, NULL, 'JOBS003', 220;

EXEC insert_employees	340, 'Ahmad', 'Rajendra', 'Male', 'AhmadRajendra@gmail.com', 
					'08219051845', '2024-07-05', 6000000, NULL, 'JOBS003', 220;

EXEC insert_employees	350, 'Wardah', 'Hannun', 'Female', 'wardahhannun@gmail.com', 
					'082193627372', '2024-07-05', 6000000, NULL, 'JOBS003', 220;

SELECT * FROM tbl_employees;
SELECT * FROM tbl_job_histories;

/*jika kita melakukan insert pada table employees maka
 data employees akan ke trigers ke table job histories
 dan menambahkan staus active */

 -- ADD DATA ACCOUNT
 CREATE PROCEDURE insert_accounts
	@id_account INT,
    @username VARCHAR(25),
    @password VARCHAR(255),
	@otp INT,
	@is_expired DATETIME,
    @is_used BIT
AS
BEGIN
    DECLARE @isValid INT;

    -- Validasi
    SET @isValid = dbo.func_password_policy(@password);

    IF @isValid = 1
    BEGIN
        -- Menyimpan username dan password ke dalam tabel
        INSERT INTO tbl_accounts (id_account, username, password, otp, is_expired, is_used)
		VALUES	(@id_account, @username, @password, @otp, @is_expired, @is_used)
		PRINT 'successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Error: Invalid input data';
    END
END;

EXEC insert_accounts 360, 'lidiasuharyanti', 'lidiasuharyanti123!', 12245, '2024-06-05', 1 ;


-- ADD DATA ROLES
CREATE PROCEDURE insert_roles
   @id_role INT,
   @name VARCHAR(25)
AS   
BEGIN
	INSERT INTO tbl_roles(id_role, name)
	VALUES (@id_role, @name);
END;

EXEC insert_roles 1, 'Super Admin';
EXEC insert_roles 2, 'Admin';
EXEC insert_roles 3, 'Manager';
EXEC insert_roles 4, 'Employee';

EXEC insert_roles 5, 'TESTING';
SELECT * FROM tbl_roles;



-- ADD PERMISSION
CREATE PROCEDURE insert_permissons
   @id_permission INT,
   @name VARCHAR(25)
AS   
BEGIN
	INSERT INTO tbl_permissions(id_permission, name)
	VALUES (@id_permission, @name);
END;

EXEC insert_permissons 1, 'db_owner';
EXEC insert_permissons 2, 'db_denydatawriter';
EXEC insert_permissons 3, 'TESTING';



-- INSERT DATA tbl_accounts
INSERT INTO tbl_accounts
VALUES	(300, 'hlmhnf', 'HilmiHanif123!', 98765, '2024-06-05', 1 ),
		(310, 'burhanudin', 'BurhanUdin123!', 12345, '2024-06-05', 1 ),
		(320, 'desinoviyanti', 'DesiNoviyanti123!', 67986, '2024-06-05',1 );

INSERT INTO tbl_accounts
VALUES	(330, 'PamanSam', 'PamanSam123!', 97765, '2024-07-05', 1 );

INSERT INTO tbl_accounts
VALUES	(340, 'ahmadrajendra', 'ahmadrajendra123!', 91765, '2024-06-05', 1 ),
		(350, 'wardahhannun', 'wardahhannun123!', 12345, '2024-06-05', 1 );



SELECT * FROM tbl_accounts;

-- INSERT DATA tbl_role_pemission
INSERT INTO tbl_role_permissions
VALUES	(1, 1, 1),
		(2, 2, 1),
		(3, 4, 2);

-- INSERT DATA tbl_account_role
INSERT INTO tbl_account_roles
VALUES	(1, 300, 1),
		(2, 310, 2),
		(3, 320, 4);

SELECT * FROM tbl_role_permissions;



-- UPDATE DATA

CREATE PROCEDURE update_regions
   @id_region int,
   @name VARCHAR(25)
AS   
BEGIN
	UPDATE tbl_regions
	SET 
		name = @name
	WHERE id_region = @id_region;
END;

EXEC update_regions @name = 'Regions Testing', @id_region = 5;
SELECT * FROM tbl_regions;



-- UPDATE COUNTRIES
CREATE PROCEDURE update_countries
	@id_country CHAR(3),
	@name VARCHAR(40),
	@id_region INT
AS
BEGIN
	UPDATE tbl_countries
	SET 
		name = @name,
		id_region = @id_region
	WHERE id_country = @id_country;
END;

EXEC update_countries @name = 'Country Testing', @id_region = 5,  @id_country = 'TST';
SELECT * FROM tbl_countries;




-- UPDATE LOCATIONS
CREATE PROCEDURE update_locations
	@id_location INT,	-- PK
	@street_address VARCHAR(40),
	@postal_code VARCHAR(12),
	@city VARCHAR(30),
	@state_province VARCHAR(25),
	@id_country CHAR(3)
AS
BEGIN
	UPDATE tbl_locations
	SET 
		street_address = @street_address,
		postal_code = @postal_code,
		city = @city,
		state_province = @state_province,
		id_country = @id_country
	WHERE id_location = @id_location;
END;

EXEC update_locations	@street_address = NULL , @postal_code = NULL, @city = 'City Testing',  
						@state_province = 'State Province Testing',  @id_country = 'TST', @id_location = 130;
SELECT * FROM tbl_locations;

-- UPDATE DEPARTMENT
CREATE PROCEDURE update_departments
	@id_department INT,	
	@name VARCHAR(30),
	@id_location INT 
AS   
BEGIN
	UPDATE tbl_departments
	SET name = @name
	WHERE id_department = @id_department;
END;

EXEC update_departments @name = 'Department Testing', @id_location = 130,  @id_department = 230;
SELECT * FROM tbl_departments;


-- UPDATE EMPLOYEES
CREATE PROCEDURE update_employees
    @id_employee INT,        
    @first_name  VARCHAR(25),
    @last_name VARCHAR(25),
    @gender VARCHAR(10),
    @email VARCHAR(25),                
    @phone VARCHAR(20),
    @hire_date DATE,
    @salary INT,
    @id_manager INT,                                        
    @id_job VARCHAR(10),        
    @id_department INT   
AS
BEGIN
    UPDATE tbl_employees
    SET 
        first_name = @first_name,
        last_name = @last_name,
        gender = @gender,
        email = @email,
        phone = @phone,
        hire_date = @hire_date,
        salary = @salary,
        id_manager = @id_manager,
        id_job = @id_job,
        id_department = @id_department
    WHERE id_employee = @id_employee;
END;


EXEC update_employees	300, 'Hilmi', 'Hanif', 'Male', 'hilmihanif@gmail.com', 
					'08884142475', '2024-06-05', 5500000, NULL, 'JOBS003', 220;

SELECT * FROM tbl_employees;
SELECT * FROM tbl_job_histories;

/*jika kita melakukan update pada table employees maka
 data employees akan ke trigers ke table job histories
 dan menambahkan staus Hand Over */


-- UPDATE JOBS
CREATE PROCEDURE update_jobs
	@id_job VARCHAR(10),
	@title VARCHAR(35),
	@min_salary INT,
	@max_salary INT
AS
BEGIN
	UPDATE tbl_jobs 
	SET	title = @title,
		min_salary = @min_salary,
		max_salary = @max_salary
	WHERE id_job = @id_job
END

EXEC update_jobs @title = 'Testing Jobs', @min_salary = 1500000,  @max_salary = 2500000, @id_job = 'JOBS004';
SELECT * FROM tbl_jobs;


-- UPDATE ROLES
CREATE PROCEDURE update_roles
	@id_role INT,
	@name VARCHAR(50)
AS
BEGIN
	UPDATE tbl_roles 
	SET name = @name
	WHERE id_role = @id_role
end;

EXEC update_roles @name = 'Testing Roles', @id_role = 5;
SELECT * FROM tbl_roles;


-- UPDATE PERMISSION
CREATE PROCEDURE update_permission
@id_permission INT,
@name VARCHAR(100)
AS
BEGIN
	update tbl_permissions 
	SET name = @name
	WHERE id_permission = @id_permission
END

EXEC update_permission @name = 'Testing Permission', @id_permission = 3;
SELECT * FROM tbl_permissions;

-- DELETE DATA

-- DELETE REGIONS
CREATE PROCEDURE delete_regions
	@id_region INT
AS   
BEGIN
	DELETE FROM tbl_regions
	WHERE id_region = @id_region;
END;


EXEC delete_regions @id_region = 5;
SELECT * FROM tbl_regions;

/* ON DELETE CASCADE Table Yang berhubungan maka akan dihapus */
/* ON DELETE SET NULL maka id yang berhubungan pada table jika dihapus akan diset NULL" */


-- DELETE COUNTRIES
CREATE PROCEDURE delete_countries
	@id_country INT
AS   
BEGIN
	DELETE FROM tbl_countries
	WHERE id_country = @id_country;
END;

SELECT * FROM tbl_countries;


-- DELETE LOCATIONS
CREATE PROCEDURE delete_location
	@id_location INT
AS   
BEGIN
	DELETE FROM tbl_locations
	WHERE id_location = @id_location;
END;


SELECT * FROM tbl_locations;


-- DELETE DEPARTMENTS
CREATE PROCEDURE delete_departments
	@id_department INT
AS   
BEGIN
	DELETE FROM tbl_departments
	WHERE id_department = @id_department;
END;

SELECT * FROM tbl_departments;

-- DELETE EMPLOYEES
CREATE PROCEDURE delete_employees
	@id_employee INT
AS   
BEGIN
	DELETE FROM tbl_employees
	WHERE id_employee = @id_employee;
END;


EXEC delete_employees @id_employee = 320;

SELECT * FROM tbl_employees;
SELECT * FROM tbl_job_histories;

/*Jika data employe di delete maka akan terjadi triggers di table job histories
  pada atribut status akan diupdate menjadi "Resign"
*/


-- DELETE JOBS
CREATE PROCEDURE delete_job
	@id_job VARCHAR(10)
AS   
BEGIN
	DELETE FROM tbl_jobs
	WHERE id_job = @id_job;
END;

EXEC delete_job @id_job = 'JOBS004';
SELECT * FROM tbl_jobs;


-- DELETE ROLES
CREATE PROCEDURE delete_roles
	@id_role INT
AS   
BEGIN
	DELETE FROM tbl_roles
	WHERE id_role = @id_role;
END;

EXEC delete_roles @id_role = 5;
SELECT * FROM tbl_roles;


-- DELETE PERMISSION
CREATE PROCEDURE delete_permissions
	@id_permission INT
AS   
BEGIN
	DELETE FROM tbl_permissions
	WHERE id_permission = @id_permission;
END;


EXEC delete_permissions @id_permission = 3;
SELECT * FROM tbl_permissions;