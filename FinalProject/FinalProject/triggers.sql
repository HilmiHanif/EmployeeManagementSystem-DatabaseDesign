-- TRIGERS INSERT EMPLOYEE
-- Menambahkan Data ke tbl_job_history dengan status Active jika data employees ditambah

CREATE TRIGGER tr_add_employees
ON tbl_employees
AFTER INSERT
AS
BEGIN
    INSERT INTO tbl_job_histories (id_employee, id_job, id_department, start_date, status)
    SELECT id_employee, id_job, id_department, hire_date, 'Active'
    FROM inserted;
END;


-- TRIGERS UPDATE EMPLOYEE
-- Update Data ke tbl_job_history dengan status Hand Over jika data id_job diupdate

CREATE TRIGGER tr_update_employee_job
ON tbl_employees
AFTER UPDATE
AS
BEGIN
    -- Memastikan hanya memproses baris yang id_job-nya berubah
    IF UPDATE(id_job)
    BEGIN
        -- Mengupdate status ke 'Hand Over' di tabel job_histories
        UPDATE tbl_job_histories
        SET status = 'Hand Over'
        FROM inserted
        INNER JOIN deleted ON inserted.id_employee = deleted.id_employee
        WHERE tbl_job_histories.id_employee = inserted.id_employee
          AND tbl_job_histories.id_job = deleted.id_job
          AND inserted.id_job <> deleted.id_job;
    END
END;


-- TRIGERS DELETE EMPLOYEE
-- Update Data ke tbl_job_history dengan status Resign jika data employees dihapus

CREATE TRIGGER tr_delete_employee
ON tbl_employees
AFTER DELETE
AS
BEGIN
    UPDATE tbl_job_histories
    SET status = 'Resign', end_date = GETDATE()
    WHERE id_employee IN (SELECT id_employee FROM deleted);
END;

/*Untuk menambahkan trigger delete saya 
 memutuskan untuk tidak menghubungkan relasi 
 antara table job histories dan employess karena
 insert/update/detele pada table job_histories 
 semua dipengaruhi oleh trigger*/

