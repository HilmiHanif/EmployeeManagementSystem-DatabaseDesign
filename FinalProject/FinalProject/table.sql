CREATE DATABASE project_final;
USE project_final;


-- REGIONS - DEPARTMENT

CREATE TABLE tbl_regions (
	id_region INT PRIMARY KEY NOT NULL,			-- PK
	name VARCHAR(25) NOT NULL			
)

CREATE TABLE tbl_countries (
	id_country CHAR(3) PRIMARY KEY,	-- PK
	name VARCHAR(40) NOT NULL,
	id_region INT NOT NULL				-- FK
)

CREATE TABLE tbl_locations (
	id_location INT PRIMARY KEY,	-- PK
	street_address VARCHAR(40),
	postal_code VARCHAR(12),
	city VARCHAR(30) NOT NULL,
	state_province VARCHAR(25),
	id_country CHAR(3)	-- FK
)

CREATE TABLE tbl_departments (
	id_department INT PRIMARY KEY,	-- PK
	name VARCHAR(30) NOT NULL,
	id_location INT NOT NULL		-- FK
)


-- PERMISSIONS - ACCOUNTS

CREATE TABLE tbl_permissions (
	id_permission INT PRIMARY KEY,		-- PK
	name VARCHAR(100) NOT NULL	
)

CREATE TABLE tbl_roles (
	id_role INT PRIMARY KEY,	--PK
	name VARCHAR(50) NOT NULL
)

CREATE TABLE tbl_role_permissions (
	id_role_permissions INT PRIMARY KEY,	-- PK
	id_role INT NOT NULL,						-- FK
	id_permission INT NOT NULL				-- FK
)

CREATE TABLE tbl_account_roles (
	id__account_role INT PRIMARY KEY, -- PK
	id_account INT NOT NULL,	-- FK
	id_role INT NOT NULL		-- FK
)

-- PK FK(tbl_employee and tbl tbl_account_role	) 
CREATE TABLE tbl_accounts (
	id_account INT PRIMARY KEY,		
	username VARCHAR(25) NOT NULL,
	password VARCHAR(255) NOT NULL,
	otp INT NOT NULL,
	is_expired DATETIME NOT NULL,
	is_used BIT NOT NULL
)


-- #1 DONEEEE


-- EMPLOYEES - JOB HISTORY

CREATE TABLE tbl_employees (
	id_employee INT PRIMARY KEY,	-- PK
	first_name  VARCHAR(25) NOT NULL,
	last_name VARCHAR(25),
	gender VARCHAR(10) NOT NULL,
	email VARCHAR(25) NOT NULL,		-- UK
	phone VARCHAR(20),
	hire_date DATE NOT NULL,
	salary	INT NULL DEFAULT 0,
	id_manager INT,					-- FK
	id_job VARCHAR(10) NOT NULL,	-- FK
	id_department INT NOT NULL		-- FK
)

SELECT * FROM tbl_employees;

	
CREATE TABLE tbl_jobs (
	id_job VARCHAR(10) PRIMARY KEY,	-- PK
	title VARCHAR(35) NOT NULL,
	min_salary INT DEFAULT 0,
	max_salary INT DEFAULT 0
)

CREATE TABLE tbl_job_histories (
	id_employee INT PRIMARY KEY,	--PK FK
	start_date DATE,
	end_date date,
	status VARCHAR NOT NULL,
	id_job VARCHAR(10) NOT NULL,	--PK
	id_department INT NOT NULL		--PK
)

ALTER TABLE tbl_job_histories
ALTER COLUMN status VARCHAR(10) NOT NULL;

-- DONEEEE




