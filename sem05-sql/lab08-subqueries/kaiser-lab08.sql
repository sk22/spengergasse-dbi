USE companydb;

-- Task 1

SELECT e_empno, e_ename, e_d_deptno, e_sal FROM e_emp
WHERE e_d_deptno = (SELECT e_d_deptno FROM e_emp WHERE e_ename = "allen");

-- Task 2

SELECT e_empno, e_ename, e_job, e_sal FROM e_emp
WHERE e_job IN (
  SELECT e_job FROM e_emp
  WHERE e_ename IN ("scott", "jones", "king")
);

-- Task 3

SELECT e_empno, e_ename, e_job, e_sal, e_hiredate FROM e_emp
WHERE e_hiredate < (
  SELECT min(e_hiredate) FROM e_emp
  INNER JOIN d_dept ON e_d_deptno = d_deptno
  WHERE d_dname = "sales" 
);

-- another solution

-- SELECT e_empno, e_ename, e_job, e_sal, e_hiredate FROM e_emp
-- WHERE e_hiredate < ALL (
--   SELECT e_hiredate FROM e_emp
--   INNER JOIN d_dept ON e_d_deptno = d_deptno
--   WHERE d_dname = "sales"
-- );

-- Task 4

SELECT e_empno, e_ename, e_job, e_e_mgr, e_sal FROM e_emp
WHERE e_job = (SELECT e_job FROM e_emp WHERE e_ename = "allen")
  AND e_e_mgr = (SELECT e_e_mgr FROM e_emp WHERE e_ename = "allen");

-- Task 5

SELECT e_empno, e_ename, e_job, e_sal, e_e_mgr FROM e_emp
WHERE e_e_mgr = (SELECT e_e_mgr FROM e_emp WHERE e_ename = "allen")
  AND e_sal <= (SELECT e_sal FROM e_emp WHERE e_ename = "turner");

-- Task 6

UPDATE e_emp SET e_sal = 2850
WHERE e_empno = 7782;


SELECT e_empno, e_ename, e_job, e_sal FROM e_emp
INNER JOIN d_dept ON e_d_deptno = d_deptno
WHERE d_dname = "accounting"
  AND e_sal = ANY (
    SELECT e_sal FROM e_emp
    INNER JOIN d_dept ON e_d_deptno = d_deptno
    WHERE d_dname = "sales"
  );
