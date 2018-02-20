DROP DATABASE IF EXISTS companydb_new;
CREATE DATABASE IF NOT EXISTS companydb_new;
USE companydb_new;

-- 1. Copy tables

CREATE TABLE d_dept
  SELECT * FROM companydb.d_dept;

CREATE TABLE e_emp
  SELECT * FROM companydb.e_emp;

CREATE TABLE s_salgrade
  SELECT * FROM companydb.s_salgrade;


-- 2. Create projects table

CREATE TABLE p_projects (
  p_projno INT PRIMARY KEY,
  p_name VARCHAR(20),
  p_budget DECIMAL(8, 2)
) ENGINE=InnoDB;


-- 3. Insert projects data

INSERT INTO p_projects VALUES
  (101, "ALPHA", 250),
  (102, "BETA", 175),
  (103, "GAMMA", 95);


-- 4. Create project number column on employees table

ALTER TABLE e_emp
  ADD COLUMN e_p_projno INT;
  

-- 5. Set project number on employees

UPDATE e_emp SET e_p_projno = 101
  WHERE e_empno IN (7782, 7369, 7566, 7698, 7788, 7876, 7902, 7657, 7658);

UPDATE e_emp SET e_p_projno = 102
  WHERE e_empno IN (7839, 7934, 7844, 7900, 7954, 7955);

UPDATE e_emp SET e_p_projno = 103
  WHERE e_empno IN (7499, 7521, 7654);


-- 6. Add foreign key

ALTER TABLE e_emp
  ADD FOREIGN KEY (e_p_projno) REFERENCES p_projects(p_projno)
    ON UPDATE CASCADE
    ON DELETE SET NULL;
