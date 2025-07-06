create database Case_Study_2
use Case_study_2
Drop database Case_Study_2
CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

CREATE TABLE JOB
(JOB_ID INT PRIMARY KEY,
DESIGNATION VARCHAR(20))

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

--Simple Queries:
--1. List all the employee details.
--2. List all the department details.
--3. List all job details.
--4. List all the locations.

select * from DEPARTMENT
select * from EMPLOYEE
select * from JOB
select * from LOCATION

--List out the First Name, Last Name, Salary, Commission for all Employees.
select FIRST_NAME,LAST_NAME,SALARY, COMM from EMPLOYEE

--. List out the Employee ID, Last Name, Department ID for all employees and
--alias
--Employee ID as "ID of the Employee", Last Name as "Name of the
--Employee", Department ID as "Dep_id"

select EMPLOYEE_ID as "ID of the Employee" , LAST_NAME as "Name of the Employee", DEPARTMENT_ID as "Dep_id" from EMPLOYEE

--List out the annual salary of the employees with their names only.

select FIRST_NAME, SALARY from EMPLOYEE

--List the details about "Smith".

select * from EMPLOYEE where LAST_NAME = 'SMITH'

--List out the employees who are working in department 20.
select * from EMPLOYEE where DEPARTMENT_ID = '20'

--List out the employees who are earning salary between 2000 and 3000.
select * from EMPLOYEE where SALARY between 2000 and 3000

--List out the employees who are working in department 10 or 20.
select * from EMPLOYEE where DEPARTMENT_ID in ('10' , '20')

 --Find out the employees who are not working in department 10 or 30.
 select * from EMPLOYEE where DEPARTMENT_ID in ('10','30')

 --List out the employees whose name starts with 'L'.
 select * from EMPLOYEE where FIRST_NAME like 'L%'

  --List out the employees whose name starts with 'L' and ends with 'E'
  select * from EMPLOYEE where FIRST_NAME like 'L%E'

  --List out the employees whose name length is 4 and start with 'J'.
  select * from EMPLOYEE where len( FIRST_NAME) =  '4' and FIRST_NAME like 'J%'

--  List out the employees who are working in department 30 and draw the
--salaries more than 2500.
select * from EMPLOYEE where DEPARTMENT_ID = '30' and SALARY > '2500'

--List out the employees who are not receiving commission.
select * from EMPLOYEE where COMM is NULL

--List out the Employee ID and Last Name in ascending order based on the
--Employee ID.
select EMPLOYEE_ID, LAST_NAME from EMPLOYEE order by EMPLOYEE_ID asc

--List out the Employee ID and Name in descending order based on salary.
select EMPLOYEE_ID , FIRST_NAME from EMPLOYEE order by SALARY desc

--List out the employee details according to their Last Name in ascending-order.
select * from EMPLOYEE ORDER BY LAST_NAME asc

--List out the employee details according to their Last Name in ascending
--order and then Department ID in descending order.
select * from EMPLOYEE order by LAST_NAME asc , DEPARTMENT_ID DESC

--List out the department wise maximum salary, minimum salary and
--average salary of the employees.
select DEPARTMENT_ID, max(SALARY) as Max_Salary, MIN(SALARY) as Min_SALARY, AVG(SALARY)as AVG_SALARY from EMPLOYEE
group by DEPARTMENT_ID

--List out the job wise maximum salary, minimum salary and average
--salary of the employees.
select JOB_ID, max(SALARY) as Max_Salary, MIN(SALARY) as Min_SALARY, AVG(SALARY)as AVG_SALARY from EMPLOYEE
group by JOB_ID

--List out the number of employees who joined each month in ascending order.
select count(EMPLOYEE_ID) as NO_OF_EMPLOYEES,HIRE_DATE from EMPLOYEE group by HIRE_DATE ORDER BY HIRE_DATE

--  List out the number of employees for each month and year in
--ascending order based on the year and month.
select COUNT(EMPLOYEE_ID) as NO_OF_EMP ,MONTH(HIRE_DATE) as MONTH_ , YEAR(HIRE_DATE) AS YEAR_ 
from EMPLOYEE group by HIRE_DATE order by HIRE_DATE

--List out the Department ID having at least four employees.

SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) AS Employee_Count
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
--HAVING COUNT(EMPLOYEE_ID) >= 4;

--How many employees joined in February month.
select count(EMPLOYEE_ID) AS NO_OF_EMP, month(HIRE_DATE) as MONTH_ from EMPLOYEE group by month(HIRE_DATE) 
Having month(HIRE_DATE) = '2' 

--How many employees joined in May or June month.
select count(EMPLOYEE_ID) AS NO_OF_EMP, month(HIRE_DATE) as MONTH_ from EMPLOYEE group by month(HIRE_DATE) 
Having month(HIRE_DATE) in ('5', '6')

--How many employees joined in 1985?
select Count(EMPLOYEE_ID) as no_of_emp from EMPLOYEE group by YEAR(HIRE_DATE) Having year(HIRE_DATE) = '1985' 

 --How many employees joined each month in 1985?
 select Count(EMPLOYEE_ID) as no_of_emp, month(HIRE_DATE) as MONTH_ from EMPLOYEE group by month(HIRE_DATE),YEAR(HIRE_DATE)
 HAVING YEAR(HIRE_DATE) = '1985'

 --How many employees were joined in April 1985?
 select count(EMPLOYEE_ID) as NO_OF_EMP ,month(HIRE_DATE) as MONTH_ , year(HIRE_DATE) as Year_
 from EMPLOYEE GROUP BY month(HIRE_DATE), year(HIRE_DATE)
 having month(HIRE_DATE) = '4' and year(HIRE_DATE) = '1985'

-- Which is the Department ID having greater than or equal to 3 employees
--joining in April 1985?

select count(EMPLOYEE_ID) as NO_OF_EMP ,month(HIRE_DATE) as MONTH_ , year(HIRE_DATE) as Year_
 from EMPLOYEE where DEPARTMENT_ID >= 3 * count(EMPLOYEE_ID) GROUP BY month(HIRE_DATE), year(HIRE_DATE),
 count(EMPLOYEE_ID), DEPARTMENT_ID
 having month(HIRE_DATE) = '4' and year(HIRE_DATE) = '1985'

 SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID) AS Employee_Count
FROM EMPLOYEE
WHERE MONTH(HIRE_DATE) = 4
  AND YEAR(HIRE_DATE) = 1985
GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID) >= 3;
select * from EMPLOYEE

--List out employees with their department names.
select *,D.Name as dept_Name from EMPLOYEE as E
inner join DEPARTMENT as D ON D.Department_Id = E.DEPARTMENT_ID

Display employees with their designations.

SELECT 
  E.EMPLOYEE_ID,
  E.FIRST_NAME,
  E.LAST_NAME,
  J.DESIGNATION
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_ID = J.JOB_ID;

--Display the employees with their department names and city.
SELECT 
  E.EMPLOYEE_ID,
  E.FIRST_NAME,
  E.LAST_NAME,
  D.Name as DEPT_Name,
  L.City
  from EMPLOYEE as E
  inner join DEPARTMENT as D
  on E.DEPARTMENT_ID = D.Department_Id
  inner join LOCATION as L
  On L.Location_ID = D.Location_Id

--  How many employees are working in different departments? Display with
-- department names.
select count(EMPLOYEE_ID) as NO_OF_EMP , D.Name from EMPLOYEE as E
inner join DEPARTMENT as D
on E.DEPARTMENT_ID =D.Department_Id
group by D.Name
select * from DEPARTMENT

--How many employees are working in the sales department?
select COUNT(EMPLOYEE_ID) as no_of_emp , D.Name from EMPLOYEE as E 
inner join DEPARTMENT as D 
on D.Department_Id = E.DEPARTMENT_ID
group by D.Name
having D.Name = 'Sales'

--Which is the department having greater than or equal to 3
--employees and display the department names in
--ascending order.
select D.name as Dept_Name from DEPARTMENT as D 
inner join  EMPLOYEE as E
on D.Department_Id = E.DEPARTMENT_ID
group by D.Name
having count(EMPLOYEE_ID) >= 3

--How many employees are working in 'Dallas'?
select count(EMPLOYEE_ID) as No_Of_Emp from EMPLOYEE as E
join DEPARTMENT as D on D.Department_Id = E.DEPARTMENT_ID
join LOCATION as L on L.Location_ID = D.Location_Id
where L.City = 'Dallas'
select * from DEPARTMENT

--Display all employees in sales or operation departments.
select E.EMPLOYEE_ID, E.FIRST_NAME,E.LAST_NAME,
  D.NAME AS Department_Name from EMPLOYEE as E
join DEPARTMENT as D
on E.DEPARTMENT_ID = D.Department_Id
where D.Name in ('Sales', 'Operations')

select * from EMPLOYEE

Display the employee details with salary grades. Use conditional statement to
create a grade column.
SELECT 
  E.EMPLOYEE_ID,
  E.FIRST_NAME,
  E.LAST_NAME,
  case
when E.SALARY < 1000 then 'Below Average'
when E.SALARY < 2000 then 'Average'
when E.SALARY < 3000 then 'above Average'
else 'High'
end as Grades 
from EMPLOYEE as E

--List out the number of employees grade wise. Use conditional statement to
--create a grade column.
SELECT 
  CASE 
    WHEN SALARY >= 3000 THEN 'A'
    WHEN SALARY >= 2000 THEN 'B'
    WHEN SALARY >= 1000 THEN 'C'
    ELSE 'D'
  END AS Grade,
  COUNT(EMPLOYEE_ID) AS Number_of_Employees
FROM EMPLOYEE
GROUP BY 
  CASE 
    WHEN SALARY >= 3000 THEN 'A'
    WHEN SALARY >= 2000 THEN 'B'
    WHEN SALARY >= 1000 THEN 'C'
    ELSE 'D'
  END
ORDER BY Grade;

--Display the employee salary grades and the number of employees between
--2000 to 5000 range of salary.
SELECT 
  CASE 
    WHEN SALARY >= 3000 THEN 'A'
    WHEN SALARY >= 2000 THEN 'B'
    WHEN SALARY >= 1000 THEN 'C'
    ELSE 'D'
  END AS Grade,
  COUNT(EMPLOYEE_ID) AS Number_of_Employees
FROM EMPLOYEE
where SALARY between 2000 and 5000
GROUP BY 
  CASE 
    WHEN SALARY >= 3000 THEN 'A'
    WHEN SALARY >= 2000 THEN 'B'
    WHEN SALARY >= 1000 THEN 'C'
    ELSE 'D'
  END

ORDER BY Grade;


 --Display the employees list who got the maximum salary.
SELECT *
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);

--Display the employees who are working in the sales department.
select EMPLOYEE_ID,FIRST_NAME from EMPLOYEE as E
join DEPARTMENT as D on 
E.DEPARTMENT_ID = D.Department_Id
where D.Name = 'Sales'SELECT *
FROM EMPLOYEE
WHERE DEPARTMENT_ID = (
  SELECT Department_Id
  FROM DEPARTMENT
  WHERE NAME = 'Sales'
);

SELECT *
FROM EMPLOYEE
WHERE DEPARTMENT_ID = (
  SELECT Department_Id
  FROM DEPARTMENT
  WHERE NAME = 'Sales'
);

Display the employees who are working as 'Clerk'
select * from EMPLOYEE
where JOB_ID = (SELECT JOB_ID from JOB where DESIGNATION = 'Clerk' )


--Display the list of employees who are living in 'Boston'.
SELECT *
FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (
    SELECT Department_Id
    FROM DEPARTMENT
    WHERE Location_Id = (
        SELECT Location_ID
        FROM LOCATION
        WHERE City = 'Boston'
    )
);

 --Find out the number of employees working in the sales department.
 select count(EMPLOYEE_ID) NO_OF_EMP from EMPLOYEE AS E
 Join DEPARTMENT as D
 on D.Department_Id = E.DEPARTMENT_ID
 group by d.Name
 having D.Name = 'Sales'

-- Update the salaries of employees who are working as clerks on the basis of
--10%.
update EMPLOYEE
set SALARY = SALARY * 1.1
where JOB_ID = ( select JOB_ID from JOB where DESIGNATION = 'CLERK')
select * from JOB

Display the second highest salary drawing employee details.
select * from EMPLOYEE
where SALARY = (Select Max(salary) from employee where SALARY < (Select Max(salary) from employee))
order by SALARY DESC

List out the employees who earn more than every employee in department 30
select * from EMPLOYEE
where SALARY = (Select Max(salary) from employee )
and DEPARTMENT_ID = '30'
select * from EMPLOYEE

Find out which department has no employees.
select D.Name from EMPLOYEE as E 
join DEPARTMENT as D
on d.Department_Id = E.DEPARTMENT_ID
where E.EMPLOYEE_ID is null

-- Find out the employees who earn greater than the average salary for
--their department.
select EMPLOYEE_ID, FIRST_NAME from EMPLOYEE
where SALARY > ( select avg(SALARY) from EMPLOYEE)