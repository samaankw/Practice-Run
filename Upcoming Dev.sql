SELECT 
    *
FROM
    departments;
    
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC; 
USE employees;

SELECT 
    MAX(emp_no)
FROM
    employees;
SELECT 
    MIN(emp_no)
FROM
    employees;
    
SELECT 
    ROUND(AVG(salary),0)
FROM
    salaries;
    

CREATE TABLE departments_dup
(
  dept_no CHAR(4) NOT NULL,
  dept_name VARCHAR(40) NOT NULL
); 

INSERT INTO departments_dup
(
  dept_no,
  dept_name
) 
select * from departments;
SELECT 
    *
FROM
    departments_dup;
    
    INSERT INTO departments_dup
(
  dept_no,
  dept_name
  
)VALUES
(
'd010',
 'Senior Analysis'
 );
 
 INSERT INTO departments_dup
 (
  dept_no,
  dept_name
) VALUES
(
  'd011',
  'Business Analysis'
); 
COMMIT;
SELECT 
    *
FROM
    departments_dup;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_name DESC;
DELETE FROM departments_dup;

DELETE FROM departments_dup 
WHERE
    dept_name = 'Business Analysis';
    
SELECT 
    *
FROM
    departments_dup;
    
INSERT INTO departments_dup
(
  dept_no
) VALUES
( 'd010'
); 

SELECT 
    *
FROM
    departments_dup;
    
SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;
COMMIT;
INSERT INTO employees
(
  emp_no,
  birth_date,
  first_name,
  last_name,
  gender,
  hire_date
  ) VALUES
  (
    999901,
    '1986-04-21',
    'John',
    'Smith',
    'M',
    '2011-01-01'
); 

COMMIT;

SELECT 
    *
FROM
    titles
LIMIT 10;


INSERT INTO employees
VALUES
(
  999903,
  '1977-09-14',
  'Johnathan',
  'Creek',
  'M',
  '1991-01-01'
); 

COMMIT;

INSERT INTO titles
VALUES
( 
  999903,
  'Senior Engineer',
  '1997-10-01',
  '9999-01-01'
);

INSERT INTO dept_emp
(
  emp_no,
  dept_no,
  from_date,
  to_date
) VALUES
(
  999903,
  'd005',
  '1997-10-01',
  '9999-01-01'
); 



SELECT 
    *
FROM
    departments
ORDER BY dept_no;

INSERT INTO departments
VALUES
( 
  'd010',
  'Business Analysis'
); 
  
  SELECT 
    *
FROM
    departments
ORDER BY dept_no;
COMMIT;
UPDATE departments_dup 
SET 
    DEPT_NO = 'd011',
    dept_name = 'Quality Control';
    

select * from departments_dup;
COMMIT;

UPDATE departments
SET
    dept_name = 'Data Analysis'
    Where
     dept_no = 'd010';
     
     Select * from departments;
     COMMIT;
     SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;
    SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM
    departments_dup
ORDER BY dept_no ASC;


ALTER TABLE departments_dup
ADD COLUMN dept_manager CHAR(50);


SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    dept_no,
    dept_name,
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name,
    COALESCE(dept_no,dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    *
FROM
    departments_dup;

ALTER TABLE departments_dup 
DROP COLUMN dept_manager;



ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;
ALTER TABLE departments_dup
CHANGE COLUMN  dept_name dept_name varchar(40) NULL;

select * from departments_dup; 
COMMIT;

INSERT INTO departments_dup(dept_name)
 VALUES ('Public Relations');
 INSERT INTO departments_dup(dept_no)
 VALUES ('d010');
 INSERT INTO departments_dup(dept_no)
 VALUES ('d011');
  Select * from departments_dup;
COMMIT;

CREATE TABLE dept_manager_dup
(
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
);
INSERT INTO dept_manager_dup
select * from dept_manager;

select * from dept_manager_dup;
COMMIT;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

select m.dept_no,m.emp_no, d.dept_name
from dept_manager_dup m
inner join
departments_dup d ON m.dept_no = d.dept_no
order by m.dept_no;

select e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date -- INNER JOINS examples
from employees e 
INNER JOIN
dept_manager d ON e.emp_no = d.emp_no;
-- LEFT JOINS/RIGHT JOINS INVERTED examples
-- practice this daily
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
FROM
    dept_manager d
        RIGHT JOIN
   employees e ON d.emp_no = e.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY d.dept_no DESC , e.emp_no;
-- The New and the Old Joins Syntax
SELECT m.dept_no, m.emp_no, d.dept_name
FROM 
     dept_manager_dup m,
     departments_dup d
WHERE 
     m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT e.first_name, e.last_name, d.dept_no, e.hire_date,d.emp_no
FROM
     dept_manager d,
     employees e
WHERE
     d.emp_no = e.emp_no;

set @@global.sql_mode := replace(@@global.sql_mode,'ONLY_FULL_GROUP_BY','');

Select e.first_name, e.last_name,e.hire_date,t.title
from employees e
INNER JOIN titles t ON e.emp_no = t.emp_no
WHERE
      first_name = 'Margareta'
      AND last_name = 'Markovitch'
ORDER BY e.emp_no;
-- CROSS JOINS
SELECT dm.*,d.*
FROM 
     dept_manager dm
		CROSS JOIN
        departments d
WHERE d.dept_no <> dm.dept_no -- what should we do if we want to display all departments but the one where the manager is currently head of ?
ORDER BY dm.emp_no,d.dept_no;


SELECT e.*,d.*
FROM
     employees e
     CROSS JOIN
     departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m   ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
		JOIN
	titles t ON e.emp_no = t.emp_no
    AND m.from_date = t.from_date
ORDER BY e.emp_no;
select d.dept_name, AVG(salary) AS average_salary
FROM 
     departments d
         JOIN 
	dept_manager m ON d.dept_no = m.dept_no
         JOIN
	salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;

select e.gender, COUNT(dm.emp_no)
FROM 
     employees e
     JOIN
	dept_manager dm ON e.emp_no = dm.emp_no
    GROUP BY gender;
    
CREATE TABLE employees_dup
(
   emp_no int(11),
   birth_date date,
   first_name VARCHAR(14),
   last_name VARCHAR(16),
   gender enum ('M','F'),
   hire_date date
); 

INSERT INTO employees_dup
SELECT e.*
from employees e
LIMIT 20;

select * from employees_dup;
COMMIT;
INSERT INTO employees_dup VALUES
('10001','153-09-02','Georgi','Facello','M','1986-06-26');
select * from employees_dup;

 SELECT 
 *
 FROM
 (SELECT
 e.emp_no, e.first_name, e.last_name, NULL AS dept_no, NULL AS from_date
 FROM
 employees e 
 WHERE 
 last_name='Denis'
 UNION SELECT 
 NULL AS emp_no,
 NULL AS first_name,
 NULL AS last_name,
 dm.dept_no,
 dm.from_date
 FROM
 dept_manager dm) as a 
 ORDER BY -a.emp_no DESC; 
 Select 
       e.first_name, e.last_name
FROM
       employees e
WHERE
      e.emp_no IN (Select
                dm.emp_no
			FROM 
                dept_manager dm);
                
Select 
      *
FROM
	dept_manager 
WHERE
     emp_no IN(Select emp_no
				From employees e
                WHERE
                      hire_date BETWEEN '1990-01-01' AND '1995-01-01');

Select 
       e.first_name, e.last_name
FROM
       employees e
WHERE
	EXISTS( Select
               *
			FROM
				dept_manager dm
			WHERE 
            dm.emp_no = e.emp_no);
Select * 
from 
     employees e
WHERE
     EXISTS( Select
             *
			FROM
            titles t
            WHERE
            t.emp_no = e.emp_no
          AND title = 'Assistant Engineer');
     
Select A.* -- SQL Subqueries Nested in Select and From examplessss
FROM
    (SELECT 
       e.emp_no AS employee_ID,
       MIN(de.dept_no) AS department_code,
       (Select 
              emp_no
		FROM
             dept_manager
		WHERE
             emp_no = 110022) AS manager_ID
	FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
	GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A
UNION Select 
      B.*

FROM
    (SELECT 
       e.emp_no AS employee_ID,
       MIN(de.dept_no) AS department_code,
       (Select 
              emp_no
		FROm
             dept_manager
		WHERE
             emp_no = 110039) AS manager_ID
	FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
	GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
	
        
CREATE TABLE emp_mananger
(
  emp_no int(11) NOT NULL,
  dept_no CHAR(4) NULL,
  manager_no int(11) NOT NULL
);


INSERT INTO emp_mananger
SELECT 
      U.*
FROM
	 (Select A.*
FROM 
    (SELECT 
       e.emp_no AS employee_ID,
       MIN(de.dept_no) AS department_code,
       (Select 
              emp_no
		FROM
             dept_manager
		WHERE
             emp_no = 110022) AS manager_ID
	FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
	GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A
UNION SELECT
   B.*

FROM
    (SELECT 
       e.emp_no AS employee_ID,
       MIN(de.dept_no) AS department_code,
       (Select 
              emp_no
		FROm
             dept_manager
		WHERE
             emp_no = 110039) AS manager_ID
	FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
	GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B 
UNION Select
     C.*
     
FROM
    (SELECT 
       e.emp_no AS employee_ID,
       MIN(de.dept_no) AS department_code,
       (Select 
              emp_no
		FROM
             dept_manager
		WHERE
             emp_no = 110039) AS manager_ID
	FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
	GROUP BY e.emp_no
    ORDER BY e.emp_no) AS C
UNION SELECT
     D.*
FROM 
    (SELECT 
       e.emp_no AS employee_ID,
       MIN(de.dept_no) AS department_code,
       (Select 
              emp_no
		FROm
             dept_manager
		WHERE
             emp_no = 110022) AS manager_ID
	FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
	GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS D) AS U; 
    
    Select * from emp_mananger;
    
    
SELECT -- self joins examples (From the mananger table, extract the record data only of those employees who are mananger as well)
    e1.*
FROM
    emp_mananger e1
        JOIN
    emp_mananger e2 ON e1.emp_no = e2.manager_no
WHERE
     e2.emp_no IN (Select
                      manager_no
				 FROM 
                      emp_mananger);

-- CREATE VIEW STATEMENT = 
CREATE VIEW v_Average_Manager_Salary AS
    SELECT 
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;
	
CREATE VIEW v_Employees_Managers AS
    SELECT 
        e.emp_no, e.first_name, e.last_name
    FROM
        employees e
            JOIN
        dept_manager m ON e.emp_no = m.emp_no
	GROUP BY emp_no;
-- STORE PROCEDURE
USE employees;
DROP PROCEDURE IF EXISTS select_employees;


SELECT 
emp_no, from_date, to_date, COUNT(emp_no) AS Num
FROM dept_emp
GROUP BY emp_no
HAVING Num > 1;

select current_date();
USE employees;

DELIMITER $$    
CREATE PROCEDURE select_employees()
BEGIN
SELECT * FROM employees
LIMIT 1000;
END$$

 DELIMITER ; 

average_salary_employee DELIMITER $$
CREATE PROCEDURE average_salary_employee()
BEGIN
SELECT emp_no,avg(salary) From salaries
LIMIT 1000;
END $$

DELIMITER ;
CALL average_salary_employee();
 
-- at this stage, we can talk about invoking the procedure. 
-- basically, there are three main ways to do this.alter
-- first one involves the following syntax

call employees.select_employees();
call select_employees();

USE employees;

DROP procedure IF EXISTS emp_salary;

DELIMITER $$
USE employee $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT
      e.first_name, e.last_name, AVG(s.salary)
FROM
      employees e
		 JOIN
	  salaries s ON e.emp_no = s.emp_no
WHERE
     e.emp_no = p_emp_no;
END $$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(in p_emp_no INTEGER, out p_avg_salary DECIMAL(10,2))
BEGIN
SELECT
      AVG(s.salary)
INTO p_avg_salary FROM
        employees e
		  JOIN
          salaries s ON e.emp_no = s.emp_no
WHERE
     e.emp_no = p_emp_no;
END $$

DELIMITER ;
-- Create a procedure called "emp_info' that uses as paramters the first and the last name of an individual, and returns their employee nu
DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar (255),in p_last_name varchar(255), out p_emp_no INTEGER)
BEGIN
     SELECT
       e.emp_no
     INTO p_emp_no FROM
           employees e
	WHERE
          e.first_name = p_first_name
          AND e.last_name = p_last_name;
END $$

DELIMITER ;

SET @v_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300,@v_avg_salary);
SELECT @v_avg_salary;
	
SET @v_emp_no = 0;
CALL employees.emp_info('Aruna','Journel',@v_emp_no);
SELECT @v_emp_no;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL (10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN

DECLARE v_avg_salary DECIMAL (10,2);

SELECT 
	AVG(s.salary)
INTO v_avg_salary FROM 
    employees e
         JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
     e.emp_no = p_emp_no;
RETURN v_avg_salary;
END $$

DELIMITER ; 

drop function IF EXISTS f_emp_avg_salary
DELIMITER $$
CREATE FUNCTION f_emp_info (p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS DECIMAL (10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN 

DECLARE v_max_from_date DATE;
 DECLARE v_salary DECIMAL (10,2);

SELECT
    max(from_date) 
INTO v_max_from_date FROM
          employees e
          JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
     e.first_name = p_first_name 
AND
   e.last_name = p_last_name;
SELECT
     s.salary
INTO v_salary FROM
	employees e 
      JOIN
	salaries s  ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name
AND
   e.last_name = p_last_name
AND 
   s.from_date = v_max_from_date;
RETURN v_salary;
END $$

DELIMITER ; 


    