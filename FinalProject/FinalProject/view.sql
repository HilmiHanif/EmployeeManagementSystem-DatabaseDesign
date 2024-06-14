-- VIEW DATA

-- VIEW REGIONS
CREATE VIEW view_regions
AS
	SELECT * FROM tbl_regions ;

SELECT * FROM view_regions;


-- VIEW DETAILREGIONS
CREATE VIEW view_detail_regions
AS
	SELECT	r.id_region,
			r.name AS name_region,
			c.id_country,
			c.name AS name_country
	FROM tbl_regions AS r 
	JOIN tbl_countries AS c 
	ON r.id_region = c.id_region;


SELECT * FROM view_detail_regions;


-- VIEW COUNTRIES
CREATE VIEW view_countries
AS
	SELECT	* FROM tbl_countries;

SELECT * FROM view_countries;

-- VIEW DETAIL COUNTRIES
CREATE VIEW view_detail_countries
AS
	SELECT	
			c.id_country,
			c.name AS name_country,
			r.id_region,
			r.name AS name_region,
			l.id_location,
			l.city
	FROM tbl_countries AS c JOIN tbl_regions AS r ON c.id_region = r.id_region
	JOIN tbl_locations AS l  ON c.id_country = l.id_country;

SELECT * FROM view_detail_countries;

-- VIEW LOCATIONS
CREATE VIEW view_locations
AS
	SELECT	* FROM tbl_locations;

SELECT * FROM view_locations;


-- VIEW DETAIL LOCATIONS
CREATE VIEW view_detail_locations
AS
	SELECT	
			l.id_location,
			l.city,
			c.id_country,
			c.name AS name_country,
			d.id_department,
			d.name AS name_department
	FROM tbl_locations AS l JOIN tbl_countries AS c ON l.id_country = c.id_country
	JOIN tbl_departments AS d  ON l.id_location = d.id_location;

SELECT * FROM view_detail_locations;

-- VIEW DEPARTMENT
CREATE VIEW view_departments
AS
	SELECT	* FROM tbl_departments;

SELECT * FROM view_departments;


-- MASIH RALAT
CREATE VIEW view_detail_departments
AS
	SELECT 
			d.id_department,
			d.name,
			d.id_location,
			l.city,
			l.state_province,
			l.id_country,
			e.id_employee,
			e.first_name
	FROM tbl_departments AS d JOIN tbl_locations AS l ON d.id_location = l.id_location
	JOIN tbl_employees AS e ON d.id_department = e.id_department

SELECT * FROM view_detail_departments;

DROP VIEW view_detail_departments;



-- VIEW PERMISSIONS
CREATE VIEW view_permissions
AS
	SELECT * FROM tbl_permissions ;

SELECT * FROM view_permissions;

-- VIEW DETAIL PERMISSIONS
CREATE VIEW view_detail_permissions
AS
	SELECT	
			p.id_permission,
			p.name,
			rp.id_role_permissions,
			id_role
	FROM tbl_permissions AS p
	JOIN tbl_role_permissions AS rp ON p.id_permission = rp.id_permission; 

SELECT * FROM view_detail_permissions;



-- VIEW ROLES
CREATE VIEW view_roles
AS
	SELECT * FROM tbl_roles ;

SELECT * FROM view_roles;

-- VIEW DETAIL ROLES
CREATE VIEW view_detail_roles
AS
	SELECT	r.id_role,
			r.name AS name_role,
			rp.id_role_permissions,
			rp.id_permission,
			ar.id__account_role,
			ar.id_account
	FROM tbl_roles AS r
	JOIN tbl_role_permissions AS rp ON r.id_role = rp.id_role
	JOIN tbl_account_roles AS ar ON r.id_role = ar.id_role; 

SELECT * FROM view_detail_roles;



-- VIEW JOBS
CREATE VIEW view_jobs
AS
	SELECT * FROM tbl_jobs ;

SELECT * FROM view_jobs;

-- VIEW JOBS
CREATE VIEW view_detail_jobs
AS
	SELECT 
		j.id_job,
		j.title,
		j.min_salary,
		j.max_salary,
		e.id_employee,
		e.first_name
	FROM tbl_jobs AS j 
	JOIN tbl_employees AS e ON j.id_job = e.id_job;

SELECT * FROM view_detail_jobs;


-- VIEW EMPLOYEES
CREATE VIEW view_employees
AS
	SELECT * FROM tbl_employees ;

SELECT * FROM view_employees;


CREATE VIEW view_detail_employees
AS
SELECT 
		e.id_employee,
		a.username,
		e.gender,
		e.email,
		e.hire_date,
		e.salary,
		e.id_manager,
		e.id_job,
		e.id_department,
		jh.status,
		d.id_location,
		r.name
	FROM tbl_employees AS e
	JOIN tbl_job_histories AS jh ON e.id_employee = jh.id_employee
	JOIN tbl_departments AS d ON e.id_department = d.id_department
	JOIN tbl_locations AS l ON d.id_location = l.id_location
	JOIN tbl_accounts AS a ON e.id_employee = a.id_account
	JOIN tbl_account_roles AS ar ON a.id_account = ar.id_account
	JOIN tbl_roles As r ON ar.id_role = r.id_role;

SELECT * FROM view_detail_employees;


SELECT * FROM tbl_departments;



	;
	
