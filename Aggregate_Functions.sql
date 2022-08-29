 /* # Introduction to aggregate functions: applied on mutiple rows of a single column of a table and return an ouput of a single value.
	  They ignore NULL values unless told not to
 Count(): counts the number of non-null records in a field.
 Sum(): sums all the non-null values in a column.
 Min(): returns the minimum value from the entire list.
 Max(): returns the maximum value from the entire list
 Avg(): calculates the average of all non-null values belonging to a certain column of a table. */

/* Count() function: frequently used in cmbination with the reserved word 'Distinct'.
Note: the parenthesis after count() must start immediately after the keyword, not after a whitespace
Question: How many employees are registered in our database? */
SELECT 
    count(emp_no)
FROM
    employees;

SELECT 
    count(first_name)
FROM
    employees; -- no null first names in the database
    
-- Count(Distinct): delivers the number of different names found throughout the data table.
-- How many different names can be found in the employees table? 
SELECT 
   count(distinct first_name)
FROM
    employees;
   
 /* Task 1. How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table? 
			Use the star symbol (*) in your code to solve this exercise.*/  
SELECT 
    *
FROM
    salaries
WHERE
    salary >= 100000;
 
 -- using count(distinct)
select 
count(distinct salary) 
from salaries 
where salary >= 100000;

-- Task 3: How many managers do we have in the employees database? 
Select * from dept_manager;

Select count(emp_no) from dept_manager;

/* Order By - Refining output. Can sort in ascending (ASC) or descending (DESC) order */
# Exercises
SELECT 
    *
FROM
    employees
 order by first_name;
 
 -- ASC - In Ascending order
 SELECT 
    *
FROM
    employees
 order by first_name ASC;
 
 -- DESC - Descending order
 SELECT 
    *
FROM
    employees
 order by first_name desc;
 
 -- it also works with numbers
 SELECT 
    *
FROM
    employees
 order by emp_no desc;

-- We can order or result by more than one fields
SELECT 
    *
FROM
    employees
 order by first_name, last_name ASC; 
 
 # Ex 1 - Select all data from the "employees" table, ordering it by "hire date" in descending order.
SELECT 
    *
FROM
    employees
 order by hire_date desc;
 
 # Ex 2
SELECT 
    *
FROM
    employees
ORDER BY first_name, last_name desc;

/* Group By Clause: */
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name;

# Ex 2
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name desc;
 
 # Ex 3
SELECT 
    first_name, count(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name desc;

 # Ex 4
SELECT 
    last_name, count(last_name)
FROM
    employees
GROUP BY last_name
ORDER BY last_name desc;

/* Aliases (AS) - Renaming a selection from your query */
SELECT 
    first_name, count(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name;

# Assignment
SELECT 
    emp_no, count(salary) 
FROM
    salaries
GROUP BY salary > 80000
ORDER BY emp_no;

# Ex 1
SELECT 
    salary, count(emp_no) 
FROM
    salaries
WHERE
    salary > 80000
GROUP BY emp_no
ORDER BY emp_no;

# Ex 2
SELECT 
    salary, count(emp_no) AS emps_with_same_salary 
FROM
    salaries
WHERE
    salary > 80000
GROUP BY emp_no
ORDER BY emp_no;

/* Having - refines output from records that do not satisfy a certain condition*/
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
Having COUNT(first_name) > 250
ORDER BY first_name;

# Exercise
SELECT 
    emp_no, avg(salary)
FROM
    salaries
WHERE
    salary > 120000
group by emp_no
order by emp_no;

# Ex 2
SELECT
*, AVG(salary)
FROM
salaries
WHERE
salary > 120000
GROUP BY emp_no
ORDER BY emp_no;

 SELECT
*, AVG(salary)
FROM
salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

/* Where vs Having - Part 1 */
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

/* Where vs Having - Part 2 */
SELECT emp_no, count(emp_no) FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

/* Limits - sets limits. Note: limit is succeeded by an integer*/
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

# Ex 2
SELECT 
    *
FROM
    salaries
ORDER BY emp_no DESC
LIMIT 10;

# Ex 3
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC
limit 10;

# Ex 4
SELECT 
    *
FROM
    dept_emp
LIMIT 100;

/* Insert Into - Part 1 */
Select * from employees
limit 10;

INSERT INTO employees
(
emp_no, 
birth_date, 
first_name, 
last_name, 
gender, 
hire_date
)
values
(
999901,
'1986-04-21',
'John',
'Smith',
'M',
'2011-01-01'
);
SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

# To delete a row
Delete from employees where emp_no = 500000;

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

Delete from employees where emp_no = 999901;

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

Delete from employees where emp_no = 999999;

SELECT * FROM employees
ORDER BY emp_no DESC
LIMIT 10;

# insert into - This inserts row into a table. Note: type int as plain numbers without quotes. After the 'insert into' quote, use the select statement to query what you have don. Only then will the result grid appear 
INSERT INTO employees
(emp_no, birth_date, first_name, last_name, gender, hire_date)
values
(999901, '1986-04-21', 'John', 'Smith', 'M', '2011-01-01');
# Query statement
SELECT * FROM employees
ORDER BY emp_no DESC
LIMIT 10;

# Insert Into - Part 2
INSERT INTO employees
(birth_date, emp_no, first_name, last_name, gender, hire_date)
values
('1973-03-26', 999902, 'Patricia', 'Lawrence', 'F', '2005-01-01');
# remember to put the values in the exact order we have listed the column name

SELECT * FROM employees
ORDER BY emp_no DESC
LIMIT 10;

# Ex - we can also insert into without the columns, just the values. But it must apear in the same order as the number of columns
INSERT INTO employees

SELECT * FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

# Assignment
SELECT * FROM titles
ORDER BY emp_no DESC
LIMIT 10;

# Titles table
insert into titles
(emp_no, title, from_date)
values (999903, 'senior_engineer', '1997-10-01');

SELECT * FROM titles
ORDER BY emp_no DESC
LIMIT 10;

# Titles dept_emp
SELECT * FROM dept_emp
ORDER BY emp_no DESC
LIMIT 10;

insert into dept_emp
(emp_no, dept_no, from_date, to_date)
values (999903, 'd005', '1997-10-01', '1999-01-01');

SELECT * FROM dept_emp
ORDER BY emp_no DESC
LIMIT 10;

/* Inserting Data INTO a New Table.
Step 1 - Create new table */
create table Business_Analysis
(
  dept_no char(4) NOT NULL,
  dept_name varchar(40) NOT NULL);
    #Query line 552
  select * from business_analysis;
  
-- Step 2 - insert new table with columns (biz_anaysis) and select old table (depts)
  insert into business_analysis (dept_no, dept_name)
   select * from departments;
      #query line 558
  Select * from business_analysis 
  order by dept_no desc
  limit 10;
  
  Drop table business_analysis;
  
-- Creating the table 'Departments Duplicate' 
  Create table departments_dup
  (dept_no char(4) Not null,
  dept_name varchar(40) Not null);
  
select * from departments_dup;

insert into departments_dup
(dept_no, dept_name)
#run query
 select * from departments; 
 
  # Let's check if the code was run properly
  select * from departments_dup
  order by dept_no;
  
  # drop table department_dup; 
  
   # Exercise: insert new dept (biz_anaysis) with new values into the departments table
   insert into departments
   values ('d010', 'Business_Analysis');
      #query line 564
    select * from departments
    order by dept_no desc
	limit 10;
    
    /* TCL - Trasaction Control Language 
The where clause: 
- If the 'where' condition is not added, all rows will be updated. This is very crucial. 
The Commit statement: 
- Saves the transaction in the database.
- Once you execute the commit statement, you cannot reverse any change! 
- used to save the state of the database at the moment of its execution
Rollback Clause:
- It allows you to take a step back i.e takes you back to the beginning or the last command that has been run
- Last changes made will not count. 
- Refers to last non-committed state. 
- Use it to undo delete 
- it will refer to the state corresponding to the last time you executed */ 
   
set autocommit = 0; # run this code before you 'commit'
commit;
    
/* The Update statement: this is used to update values of eisting records in a table */
select * from employees
where emp_no = 999901;

-- now update record of emp_no 999901
update employees
set
first_name = 'Stella',
last_name = 'Parkinson',
birth_date = '1990-12-31',
gender = 'F'
where 
emp_no = 999901;

# run query
select * from employees
where emp_no = 999901;

/* The update statement 2: when updating a table, the 'where' clause is crucial. if this condition is not provided, all rows will be updated.*/
select * from departments_dup
order by dept_no;

commit; # execute the commit command to save the dataset 

update departments_dup
set
dept_no = 'd011',
dept_name = 'Quality control'; # after unchecking the safe update mode, close MySQL workbench

select * from departments_dup
order by dept_no;

rollback; 

# Check to see that the rollback has been effected
select * from departments_dup
order by dept_no; 

commit; #execute another commit statement after the rollback to return to state before the update

# drop table departments_dup;

# Exercise
select * from departments
order by dept_no;

# update depts table
update departments
set
dept_name = 'data analysis'
where
dept_no = 'd010';
# Query
select * from departments
order by dept_no desc;

/* SQL delete statement - Part 1: Removes record from a database*/

select * from employees
where emp_no = 999903;

select * from titles
where emp_no = 999903;

delete from employees
where emp_no = 999903; 

rollback; /* please note that you cannot rollback if you haven't first committed. this is the reason why we cannot rollback the deteled data. 
Hence, re-insert the data of Emp_no 999903 and continue 
Note: before you delete, ensure to commit the data first so you can rollback*/

SELECT * FROM employees
ORDER BY emp_no DESC
LIMIT 10;

insert into employees
(emp_no, birth_date, first_name, last_name, gender, hire_date)
values (999903, '1977-09-14', 'Jonathan', 'Creek', 'M', '1999-01-01');

insert into titles
(emp_no, title, from_date)
values (999903, 'senior_engineer', '1997-10-01');

SELECT * FROM titles
ORDER BY emp_no DESC
LIMIT 10;

commit;

# delete record for emp_no 99903
delete from employees
where emp_no = 999903; 

# check if it's been deleted
SELECT * FROM employees
ORDER BY emp_no DESC
LIMIT 10;

SELECT * FROM titles
ORDER BY emp_no DESC
LIMIT 10;

rollback; # verify rollback of the records

# Delete statement 2
select * from departments_dup
  order by dept_no; # not working because it didnt work earlier
 
 Delete from departments_dup;
 
 rollback;
  
# Exercise - remove dept number 10 record from the dept table   
select * from departments
where dept_no = 'd010';

delete from departments
where dept_no = 'd010';

/* drop vs truncate vs delete - the functionality is similar
Drop: removes record, table, columns and structure completely.
	- you wont be able to roll back to its initial state, or to the last 'Commit' statement
    - use only when you are sure you wont need the records anymore
Truncate: removes all records from a table but its structure remains intact
		 - truncate is like delete without the where clause
         - when truncating, auto-increment values will be reset 
           e.g, if table has 10 records and then you truncate it, filling in the next record will begin table from one and not eleven
Delete: removes records row by row
		only rows specified in the where clause will be deleted
        if the where clause is ommitted, it will be as though you truncated
 Note: truncate delivers the output faster than delete because it doesnt remove the info row by row  
		auto-increment values are not reset with delete e.g if table has 10 records and then you delete it, filling in the next record will begin table from eleven and not one
 */
 
 /* SQL Functions
 Aggregate functions: gathers data from many rows of a table and aggregates it into a single value. 
					  they are sumarizing functions.
                      they ignore null values throughout the field to which they are applied.
  
  COUNT() - applicable to both numeric and non-numeric data */
 select * from salaries
 order by salary desc
 limit 10;
 
 select count(salary) # no of salaries contract
 from salaries;

# how many employee start dates are in the database
 select count(from_date) 
 from salaries;
 
 -- Count(distinct): helps us find the number of times unique values are encountere in a given column
 select count(distinct from_date) # contracts signed from date
 from salaries;
 
 # count(*): returns the number of all rows of the table, Null values included
 select count(*) # whether null values are taken into account
 from salaries;
 
 select * from salaries
 order by salary DESC
 Limit 10;
 
/* Note: the parenthesis & the arguement must be attached to the name of the aggregate function
		 You should not leave white space before opening the parentheses */
 
 /* Sum() function: */
 select sum(salary) # total salaries contract
 from salaries;
 
 /* the * only goes well with the count() function. it doesnt work with other agregate functions.
 Note that count() is applicable to both numeric and non-numeric data.
			sum(), min(), max(), avg() all work with numeric data.*/
            
 /* Max() and Min() functions: returns the maximum and minimum value of a column*/
 select max(salary) # highest salaries 
 from salaries;
 
  select min(salary) # lowest salaries 
 from salaries;
 
 #Exercises: 1. Which is the lowest employee number in the database?
 select min(emp_no)  
 from employees;
 
 # 2. Which is the highest employee number in the database?
 select max(emp_no) 
 from employees;
 
 /*AVG(): Extracts the average value of all non-null values in a field
 Question: Which is the average annual salary the company's employee received? */
 select Avg(salary)  
 from salaries;
 
 # Exercise: What is the average annual salary paid to employees who started after the 1st of January 1997?
 select Avg(salary)  
 from salaries
 where from_date > '1997-01-01';
 
 /*ROUND(): usually applied to the single values that aggregate functions return*/
 select Round(Avg(salary))
 from salaries;
 
 # Rounding to a decimal place of choice
 select Round(Avg(salary), 2)
 from salaries;
 
 # Exercise: Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents.
 select round(Avg(salary), 2)
 from salaries
 where from_date > '1997-01-01';
 
 /* Coalesce() - Preamble - So, let’s adjust the “Departments” duplicate in a way that suits the
purposes of the next video, in which we will work with IF NULL() and
COALESCE().*/
 SELECT * FROM departments_dup;
 
Alter Table departments_dup
change column dept_name dept_name varchar(40) null; 

delete from departments_dup
where dept_no = 'd010';

delete from departments_dup
where dept_no = 'd011';

SELECT * FROM departments_dup
ORDER BY dept_no ASC;

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

SELECT
*
FROM 
departments_dup
ORDER BY dept_no ASC; 

Commit;

ALTER TABLE employees.departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;

SELECT
*
FROM 
departments_dup
ORDER BY dept_no ASC; 

Commit;

/*IF NULL() and COALESCE(): They do not make any changes to the data set. They create output where certain data values appear in place of NULL values.
IFNULL - returns the first of the two indicated values if the data value found in the table is not null, and returns the second value if there is a null value
	   - prints the returned value in the column of the output*/
SELECT
*
FROM 
departments_dup
ORDER BY dept_no;

# IfNull() cannot contain more than two parameters 
 SELECT
 dept_no,
 IFNULL(dept_name, 'Department name not provided') as dept_name
FROM 
departments_dup;

/* This is where Coalesce steps in. 
It allows you to insert N arguments in the parenthesis
Coalesce() can be seen as IFNULL() with more than two parameters
Coalesce() with 2 arguments will work exactly as IFNULL()
COALESCE() - returns a single value of the ones we have within parentheses, and this value will be the first non-null 
			 values of this list, reading the values from left to right*/
# Coalesce() with two arguements
SELECT
 dept_no,
 coalesce(dept_name, 'Department name not provide') as dept_name
FROM 
departments_dup;

# Coalesce() with three arguements
SELECT
*
FROM 
departments_dup
ORDER BY dept_no;

SELECT
 dept_no,
 dept_name,
 coalesce(dept_manager, dept_name, 'N/A') as dept_manager
FROM 
departments_dup
Order by dept_no ASC;

#IFNULL() and COALESCE() do not make any changes to the data set. They merely create an output where certain data values appear in place of NULL values.

/* Another Example of using COALESCE(): 
It can help you visualize a prototype of the table's final version
Note that this trick is carried out by Coalesce only. If substituted with IFNULL, it returns as an error. This because;
IFNULL() works with precisely two arguments
COALESCE() can have one, two, or more arguments*/
SELECT
 dept_no,
 dept_name,
 coalesce('department manager name') as fake_col
FROM 
departments_dup;

/* Exercise - 
Task 1 - Select the department number and name from the departments_dup table and add a third column 
		 where you name the department number (dept_no) as dept_info. If dept_no does not have a value, use dept_name */
SELECT
 dept_no,
 dept_name,
 coalesce(debt_no, dept_name, dept_name) as dept_info
FROM 
departments_dup
Order by dept_no ASC;

SELECT
*
FROM 
departments_dup
ORDER BY dept_no;

/* Task 2: Modify the code obtained from the previous exercise in the following way. 
		   Apply the IFNULL() function to the values from the first and second column, so that N/A is displayed whenever a department number has no value, 
           and Department name not provided is shown if there is no value for dept_name.*/
