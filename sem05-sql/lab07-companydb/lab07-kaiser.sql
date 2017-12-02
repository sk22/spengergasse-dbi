-- Task "Abfragen SQL Firmenmodell" by Samuel Kaiser
-- December 2, 2017

USE companydb;

-- Task 1

SELECT DISTINCT e_job FROM e_emp;

-- Task 2

SELECT d_dname AS department, d_deptno AS deptnummer FROM d_dept;

-- Task 3

SELECT e_empno, e_ename, e_job, e_sal, e_comm FROM e_emp WHERE e_comm > e_sal;

-- Task 4

SELECT e_empno, e_ename, e_job, e_sal FROM e_emp
  WHERE e_d_deptno = 30 AND e_sal >= 1500;

-- Task 5

SELECT e_empno, e_ename, e_job, e_sal FROM e_emp
  WHERE e_job = "manager" OR e_sal > 3000;

-- Task 6

SELECT e_empno, e_ename, e_job, e_sal FROM e_emp
  WHERE e_job IN ("manager", "salesman") AND e_sal > 1500;

-- Task 7

SELECT e_empno, e_ename, e_job FROM e_emp
  WHERE e_job = "manager" AND e_d_deptno != 30;

-- Task 8

SELECT e_empno, e_ename, e_job FROM e_emp
  WHERE e_d_deptno = 10 AND e_job NOT IN ("manager", "clerk");

-- Task 9

SELECT e_empno, e_ename, e_job, e_sal FROM e_emp
  WHERE e_sal BETWEEN 1200 AND 1300;

-- Task 10

SELECT e_empno, e_ename, e_job, e_sal FROM e_emp
  WHERE e_sal < 1200 OR e_sal > 1300;

-- Task 11

SELECT e_empno, e_ename, e_job FROM e_emp
  WHERE e_job NOT IN ("clerk", "analyst", "salesman");

-- Task 12

SELECT e_empno, e_ename, e_job FROM e_emp WHERE left(e_ename, 1) = "M";

-- Task 13

SELECT e_empno, e_ename, e_job FROM e_emp WHERE length(e_ename) = 5;

-- Task 14

SELECT e_empno, e_ename, e_job, e_sal FROM e_emp
  WHERE e_d_deptno = 30
  ORDER BY e_sal DESC;

-- Task 15

SELECT e_empno, e_ename, e_job FROM e_emp ORDER BY e_job, e_ename;

-- Task 16

SELECT
  e_empno,
  e_ename,
  e_job,
  e_sal,
  e_comm,
  s_grade
  FROM e_emp
  INNER JOIN s_salgrade ON e_sal BETWEEN s_losal AND s_hisal
  ORDER BY e_sal DESC;

-- Task 17

SELECT * FROM d_dept;

-- Task 18

SELECT d_dept.* FROM d_dept
  LEFT JOIN e_emp ON d_deptno = e_d_deptno
  WHERE e_empno IS NULL;

-- Task 19

SELECT
  e_empno,
  e_ename,
  e_job,
  e_sal,
  e_comm,
  e_sal + coalesce(e_comm, 0) AS e_income
  FROM e_emp;

-- Task 20

SELECT e_empno, e_ename, e_job, e_comm
  FROM e_emp
  WHERE coalesce(e_comm, 0) > (e_sal * 0.25);

-- Task 21

SELECT e_empno, e_ename, e_job, e_comm, e_sal
  FROM e_emp
  ORDER BY e_comm / e_sal DESC, e_sal DESC;

-- Task 22

SELECT
  e_empno,
  e_ename,
  e_job,
  e_sal * 12 AS e_sal_year
  FROM e_emp;

-- Task 23

SELECT
  e_empno,
  e_ename,
  e_job,
  e_sal / 30 * 22 AS e_real_sal,
  round(e_sal / 30 * 22) AS e_real_sal_dollars,
  round(e_sal / 30 * 22, 2) AS e_real_sal_pence
  FROM e_emp;

-- Task 24

SELECT avg(e_sal) AS e_avg_sal_clerks FROM e_emp WHERE e_job = "clerk";

-- Task 25

SELECT sum(e_sal + coalesce(e_comm, 0)) AS e_sum_sal_comm FROM e_emp;

-- Task 26

SELECT avg((e_sal + coalesce(e_comm, 0) * 12)) AS e_avg_sal_comm_year
  FROM e_emp;

-- Task 27

SELECT e_empno, e_ename, e_sal FROM e_emp
  WHERE e_sal IN (
    (SELECT min(e_sal) FROM e_emp),
    (SELECT max(e_sal) FROM e_emp)
  );

-- Task 28

SELECT count(e_empno) AS e_count_dept_30 FROM e_emp WHERE e_d_deptno = 30;

-- Task 29

SELECT e_job, count(e_empno) AS e_count_job FROM e_emp GROUP BY e_job;
