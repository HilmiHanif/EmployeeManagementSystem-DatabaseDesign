-- REGIONS - DEPARTMENT
-- CONSTRAINT FOREIGN KEY

-- tbl_regions to tbl_countries
ALTER TABLE tbl_countries 
ADD CONSTRAINT fk_regions_countries FOREIGN KEY (id_region)
REFERENCES tbl_regions (id_region)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- tbl_countries to tbl_locations
ALTER TABLE tbl_locations 
ADD CONSTRAINT fk_countries_locations FOREIGN KEY (id_country)
REFERENCES tbl_countries (id_country)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- tbl_locations to tbl_departments
ALTER TABLE tbl_departments
ADD CONSTRAINT fk_locations_departments FOREIGN KEY (id_location)
REFERENCES tbl_locations (id_location)
ON UPDATE CASCADE
ON DELETE CASCADE;


-- PERMISSION - ACCOUNT
-- CONSTRAINT FOREIGN KEY

--tbl_permissions - tbl_role_permissions
ALTER TABLE tbl_role_permissions 
ADD CONSTRAINT fk_permissions_role_permissions FOREIGN KEY (id_permission)
REFERENCES tbl_permissions (id_permission)
ON UPDATE CASCADE
ON DELETE CASCADE;

--tbl_roles - tbl_role_permissions
ALTER TABLE tbl_role_permissions 
ADD CONSTRAINT fk_roles_role_permissions FOREIGN KEY (id_role)
REFERENCES tbl_roles (id_role)
ON UPDATE CASCADE
ON DELETE CASCADE;

--tbl_roles - tbl_account_roles 
ALTER TABLE tbl_account_roles 
ADD CONSTRAINT fk_roles_account_roles FOREIGN KEY (id_role)
REFERENCES tbl_roles (id_role)
ON UPDATE CASCADE
ON DELETE CASCADE;

--tbl_accounts - tbl_account_roles 
ALTER TABLE tbl_account_roles 
ADD CONSTRAINT fk_account_account_roles FOREIGN KEY (id_account)
REFERENCES tbl_accounts (id_account)
ON UPDATE CASCADE;


-- DONEEEE



-- Remaining  Foreign Key

--tbl_departments to tbl_employees
ALTER TABLE tbl_employees
ADD CONSTRAINT fk_departments_employees FOREIGN KEY (id_department)
REFERENCES tbl_departments (id_department)
ON UPDATE CASCADE
ON DELETE CASCADE;

--tbl_departments to tbl_job_histories
ALTER TABLE tbl_job_histories
ADD CONSTRAINT fk_departments_job_histories FOREIGN KEY (id_department)
REFERENCES tbl_departments (id_department)
ON UPDATE CASCADE
ON DELETE CASCADE;

--tbl_jobs to tbl_employees
ALTER TABLE tbl_employees
ADD CONSTRAINT fk_jobs_employees FOREIGN KEY (id_job)
REFERENCES tbl_jobs (id_job)
ON UPDATE CASCADE
ON DELETE CASCADE;

--tbl_job_histories to tbl_employees
ALTER TABLE tbl_job_histories
ADD CONSTRAINT fk_jos_histories_employees FOREIGN KEY (id_employee)
REFERENCES tbl_employees (id_employee);

ALTER TABLE tbl_job_histories
DROP CONSTRAINT fk_jos_histories_employees;

--tbl_jobs to tbl_jobs_histories
ALTER TABLE tbl_job_histories
ADD CONSTRAINT fk_job_jobs_histories FOREIGN KEY (id_job)
REFERENCES tbl_jobs (id_job)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- tbl_employees - tbl_account 
ALTER TABLE tbl_employees
ADD CONSTRAINT fk_account_employees FOREIGN KEY (id_employee)
REFERENCES tbl_accounts (id_account);


-- CONNTRAINT UNIQ KEY

ALTER TABLE tbl_employees  
ADD CONSTRAINT uniq_email UNIQUE (email);


-- DONE



