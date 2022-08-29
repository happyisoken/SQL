/* Introduction to Joins: A tool that allows us construct a relationship between objects.
   Relational schemas: A perfect too that helps find a strategy for linking tables. 
  A Join shows a result set containing fields derived from 2 or more tables.
  In using Joins:
  1. we must find a related column from 2 tables that contain same type of data.
  2. we will be free to add columns from the two tables to our output.
Note the following:
i. the columns used to relate tables must represent the same objects such as ID. 
ii. the tables being considered need not be logically adjacent. */

-- Assignment - Task 1

Drop table if exists departments_dup;
create table departments_dup
(
dept_no char(4) Null,
dept_name varchar(40) Null);

insert into departments_dup
(
dept_no,
dept_name
)
select * from departments
order by dept_no;

insert into departments_dup (dept_name)
values ('Public Relations');

select * from departments_dup
order by dept_no;

Delete from departments_dup
where
dept_no = 'd002';

insert into departments_dup (dept_no)
values ('d010'), ('d011');

# creating dept_manager duplicate
Drop table if exists dept_manager_dup;
Create table dept_manager_dup
(
emp_no int(11) Not Null,
dept_no char(4) Null,
from_date date Not Null,
to_date date Null);

insert into dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES 
(999904, '2017-01-01'),
(999905, '2017-01-01'),
(999906, '2017-01-01'),
(999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';

/* Inner Join: Helps us extract only records in which all values in the related columns match.
The result set are all areas common to two or more different tables. 
The values that match two tables are called matching values or matching records.
The values that do not match are called non-matching values or records */

Select * from dept_manager_dup
order by dept_no;

Delete from departments_dup
where
dept_name = 'data analysis';

Select * from departments_dup
order by dept_no;

/* The join syntax shows columns from the different tables and specifying which the related column will be 
1. Select: all columns you wish to see in the result  
2. From: the first table
3. Join: the name of the second table (matching with the first table)
4. On: the columns that relate the two tables. Use the equality sign surrounded by the column names you are specifying.
Use Aliases to rename table names. When used for assigning table names, add it after the original table name without using the keyword AS
*/

/* Inner Joins - Extracts only records in which the values in the related columns match.
Part 2: 'm' and 'd' are aliases for dept_manager_dup and departments_dup tables respectively */
Select m.dept_no, m.emp_no, d.dept_name  
from dept_manager_dup m
inner join
departments_dup d on m.dept_no = d.dept_no 
order by m.dept_no;
 
-- Null values or values appearing in just one of the two tables and not appearing in the other, are not displayed. Only Non-Null matching values are in play 

/* Assignment: Extract a list containing information about all managers' employee number, first and last name, department number, and hire date*/
Select e.emp_no, e.first_name, e.last_name, e.hire_date, m. dept_no
from employees e
join dept_manager_dup m on e.emp_no = m.emp_no
order by e.emp_no;

/* A Note on Using Joins:
1. The word Inner is not obligatory and so can be omitted. Inner Join = Join
2. The order in which we specify the matching columns does not matter
3. In the Order By clause, we do not have to include the table indication. */ 

Select m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name  
from dept_manager_dup m
inner join
departments_dup d on m.dept_no = d.dept_no 
order by m.dept_no;

/* Duplicate Records: Aka Duplicate rows, are identical rows in an SQL table. They are not allowed in a database or data table. 
*/
INSERT INTO dept_manager_dup
VALUES 
('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'Customer Service');

Select * from dept_manager_dup
order by dept_no ASC;

Select * from departments_dup
order by dept_no ASC;

Select m.dept_no, m.emp_no, d.dept_name  
from dept_manager_dup m
Join
departments_dup d on m.dept_no = d.dept_no 
order by m.dept_no;

# Removing duplicates

Select m.dept_no, m.emp_no, d.dept_name  
from dept_manager_dup m 
Join
departments_dup d on m.dept_no = d.dept_no 
group by m.emp_no # always group the joins by the field that differs most among records
order by m.dept_no;

/* Left Join - Part 1  
In certain occassions, the order in which we join tables in SQL matter */
# Remove duplicates from the two tables

Delete from dept_manager_dup
where emp_no = '110228';

delete from departments_dup
where dept_no = 'd009';

# add back the initial records
INSERT INTO dept_manager_dup
VALUES 
('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'Customer Service');

# Left join - Part 2
Select m.dept_no, m.emp_no, d.dept_name  
from dept_manager_dup m 
left Join
departments_dup d on m.dept_no = d.dept_no 
group by m.emp_no 
order by m.dept_no;

Select d.dept_no, m.emp_no, d.dept_name
from
departments_dup d
left join
dept_manager_dup m ON m.dept_no = d.dept_no
order by d.dept_no;

/* Right Join: their functionality is identical to Left Joins, with the only difference being that the direction of the operation is inverted 
   Right Join = Right Outer Join
   - when applying a right join, all the records from the right table will be included in the result set.
   - values from the left table will be included only if their linking column contains a value coinciding, or matching, with a value from the linking column of the right table.
   - Left and Right joins are perfect examples of one-to-many relationships.*/
   
 Select m.dept_no, m.emp_no, d.dept_name  
from dept_manager_dup m 
Right Join
departments_dup d on m.dept_no = d.dept_no 
order by m.dept_no;  

-- whether we run a Right or a Left Join with an inverted tables order, we will obtain the same output. 
-- right joins are seldom applied in practice
-- matching column = linking column

/* The new & old join syntax 
Exercise - Old Join Syntax (with the where statement) */
select e.emp_no, e.first_name, e.last_name, e.hire_date, dm.dept_no
from 
employees e, dept_manager dm
where
e.emp_no = dm.emp_no;

-- using the new join syntax (without the where statement)
select e.emp_no, e.first_name, e.last_name, e.hire_date, dm.dept_no
from 
employees e
Join
dept_manager dm on e.emp_no = dm.emp_no;

#Exercise
select e.first_name, e.last_name, e.hire_date, t.title 
from
employees e, 
titles t 
where first_name = 'Margareta' and last_name = 'Markovitch';

-- Or
select e.first_name, e.last_name, e.hire_date, t.title 
from
employees e
join
titles t 
where first_name = 'Margareta' and last_name = 'Markovitch';

/* JOIN and WHERE Used Together */
select e.emp_no, e.first_name, e.last_name, s.salary
from
employees e
Join
salaries s on e.emp_no = s.emp_no
where
s.salary > 145000;

-- we can do without the emp_no
select e.first_name, e.last_name, s.salary
from
employees e
Join
salaries s on e.emp_no = s.emp_no
where
s.salary > 145000;

/* CROSS JOIN: Takes values from a certain table & connects them with all values from the tables we want to join it with
Inner Join - connects only matching values 
Cross Join - connects all the values, not just those that match. It is useful when tables in the database are not well connected
*/
-- Connecting all the values from the depts table with all the values from the dept_manager table.
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- Alternatively, we can use the Old join syntax 
SELECT 
    dm.*, d.*
FROM
    dept_manager dm,
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- A third way to write is that without the word Cross Join. Here, the cross is removed leaving only the Join. All 3 gives same result
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
    join
    departments d
ORDER BY dm.emp_no , d.dept_no;

/* Join without ON = not considered best practice
Cross Join = best practice. The first code with the Cross Join is the best practice */

-- displaying all depts but the one where the manager is currently heading
SELECT 
    dm.*, d.*
FROM
    departments d
    cross join
    dept_manager dm
    where
    d.dept_no <> dm.dept_no -- dept_no from depts table is different from dept_no of the depts managers table
ORDER BY dm.emp_no , d.dept_no;

/* In summary,
 Cross join = Inner Join = the old join syntax
 Join + On clause = Cross Join + where
 In all 3 cases, the results will be same. */
 
 # We can cross Join more than 2 tables. Be careful because a lot of records => the result might become too big!
SELECT 
    e.*, d.*
FROM
    departments d
    cross join
    dept_manager dm
    join
    employees e ON dm.emp_no = e.emp_no
    where
    d.dept_no <> dm.dept_no -- condition that the dept_no in the depts table is different from (<>) the dept_no in the employees table
ORDER BY dm.emp_no , d.dept_no;

/* Assignment
Task 1:
Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9*/
-- Solution
select dm.*, d.*
from 
dept_manager dm
cross join 
departments d
on dm.dept_no = d.dept_no
where d.dept_no = 'd009'
ORDER BY dm.dept_no;

/*Task 2: Return a list with the first 10 employees with all the departments they can be assigned to.
Solution */
select e.*, d.*
from employees e 
cross join departments d
where e.emp_no < 10011
order by e.emp_no;

select emp_no from employees;

/* Using Aggregate Functions with Joins: 
To Find the average salary of men and women in a company */

Select 
e.gender, AVG(salary) As average_salary
from 
employees e
join salaries s on e.emp_no = s.emp_no
group by gender;

/* JOIN more that two tables in SQL */ 
select
e.first_name,
e.last_name,
e.hire_date,
dm.from_date,
d.dept_no
from employees e 
join dept_manager dm on e.emp_no = dm.emp_no
join departments d on dm.dept_no = d.dept_no;

# Assignment: Select all managers' first and last name, hire date, job title, start date, and department name.
-- solution
select
e.first_name,
e.last_name,
e.hire_date,
t.title,
dm.from_date,
d.dept_name
from employees e 
join titles t on e.emp_no = t.emp_no
join dept_manager dm on t.emp_no = dm.emp_no
Join departments d on dm.dept_no = d.dept_no;

/* Tips and tricks for joins: 
 Joins: Look for key columns which are common between the tables involved in the analysis and are necessary to solve the task at hand
		These columns do not need to be foreign or private keys
        
        obtain the names of all depts and calculate the average salary paid to managers */
Select d.dept_name, AVG(salary)
from
departments d
join
dept_manager m ON d.dept_no = m. dept_no
join
salaries s ON m.emp_no = s.emp_no
group by d.dept_name;

-- a more professional query
Select d.dept_name, AVG(salary) As average_salary
from
departments d
join
dept_manager m ON d.dept_no = m. dept_no
join
salaries s ON m.emp_no = s.emp_no
group by d.dept_name 
order by average_salary;

-- given a condition where average salary is greater than 60,000

Select d.dept_name, AVG(salary) As average_salary
from
departments d
join
dept_manager m ON d.dept_no = m. dept_no
join
salaries s ON m.emp_no = s.emp_no
group by d.dept_name -- always group-by column of interest
having average_salary > 60000 -- having and group by goes together
order by average_salary desc;

# Assignment - How many male and how many female managers do we have in the "employees" database?
Select e.gender, count(dm.emp_no)
from employees e
join dept_manager dm on e.emp_no = dm.emp_no
group by gender
order by gender;

select * from dept_manager;

/* UNION vs UNION ALL
Union All: used to combine a few select statements in a single output.
		  - It is a tool that allows one unify tables. 
          - retrieves the duplicates as well*/

-- Create employees dup table 
Drop table if exists employees_dup;
Create table employees_dup (
emp_no  int(11),
birth_date date,
first_name varchar (14),
last_name varchar (16),
gender enum ('M', 'F'),
hire_date date);

-- duplicate the structure of the employees table
Insert into employees_dup
select
e.*
from
employees e
Limit 20;

-- insert a duplicate of the first row
Insert into employees_dup Values
('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

-- check table
select * from employees_dup;

-- Union vs Union All

-- UNION All
select
e.emp_no,
e.first_name,
e.last_name,
Null As dept_no,
Null As from_date
from
employees_dup e 

where
e.emp_no = 10001

Union All select
Null As emp_no,
Null As first_name,
Null As last_name,
m.dept_no,
m.from_date
from
dept_manager m;

-- UNION
select
e.emp_no,
e.first_name,
e.last_name,
Null As dept_no,
Null As from_date
from
employees_dup e 
where
e.emp_no = 10001
Union select
Null As emp_no,
Null As first_name,
Null As last_name,
m.dept_no,
m.from_date
from
dept_manager m;

/* Summary: When uniting two identically organized tables:
Union - 1. It displays only distinct values in the output
		2. It uses more MySQL resources (more computational power and storage space)
        3. For better results, use Union.
Union All - 1. It retrieves the duplicates as well
			2. To optimize performance, use Union All*/

/* SQL Subqueries with IN nested inside WHERE 
Subqueries = Inner queries = Nested queries = inner select
Subquerries: Are queries embedded in a query.
			 They are part of another quer called an outer query/outer select.	
             They are applied in the where clause of a select statement.
             They should always be placed within parentheses.
             May return a single value (scalar), a single row, a single column, or an entire table.
             You can have a lot more than one subquery in your outer query.
             It is possible to nest inner queries within other inner queries.
*/
Select * from dept_manager;
Select e.first_name, e.last_name
from
employees e 
where e.emp_no IN 			# outer query
(select dm.emp_no
from
dept_manager dm); 			# inner query 

select dm.emp_no
from
dept_manager dm;

/* 1. SQL engine starts by running the inner query
   2. then it uses its returned output, which is intermediate, to execute the outer query.
	3. SQL engine executes the innermost query first, then the subsequent query, until it runs the outermost query last.*/ 
    
-- Assignment - Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.
Select * from dept_manager 
where
emp_no IN (select emp_no
from
employees where hire_date between '1990-01-01' and '1995-01-01');

select emp_no
from
employees where hire_date between '1990-01-01' and '1995-01-01';

-- Assignment: Go forward to the solution and execute the query. What do you think is the meaning of the minus sign before subset A in the last row (ORDER BY -a.emp_no DESC)?

/* SQL Subqueries with EXISTS-NOT EXISTS nested inside WHERE: 
Exists: Checks whether certain row values are found within a subquery. This check is conducted row by row. It returns a boolean value
  Exists - Tests row values for exixtence 					IN - Searches among values
		   Is quicker in retrieving large amount of data 		 Is faster with small datasets
Ensure that the Order by clause is in the outer query and not within the parenthesis of the inner query.
Subqueries:
- allows for better structuring of the outer query
- Each inner query can be thought of in isolation. Hence the name of SQL!
- Many users prefer subqueries simply because they offer enhanced code readability
- In some situations, the use of subqueries is much more intuitive compared to the use of complex joins and unions*/
Select 
e.first_name, e.last_name
from
employees e
where
exists(select * from dept_manager dm
where
dm.emp_no = e.emp_no);

Select 
e.first_name, e.last_name
from
employees e
where
exists(select * from dept_manager dm
where
dm.emp_no = e.emp_no)
order by emp_no;

select * from dept_manager dm
where
dm.emp_no = e.emp_no
order by emp_no;

-- Assignment: Select the entire information for all employees whose job title is "Assistant Engineer".

-- An attempt using the join syntax
select e.*, t.title from employees e
        join titles t on e.emp_no = t.emp_no
        where title = 'Assistant Engineer';

-- correct code using where exists 
Select e.*, t.title 
from
employees e,
titles t
where e.emp_no = t.emp_no and 
Exists(select * from titles  
where t.emp_no = e.emp_no
and t.title = "Assistant Engineer");

-- Or
Select e.*, t.title 
from
employees e,
titles t
where e.emp_no = t.emp_no and 
Exists(select * from titles  
where t.title = "Assistant Engineer");

/* SQL Subqueries nested in SELECT and FROM: Can be executed with a select statement or with a from clause as well.

Question: Assign employee number 110022 as a manager to all employees from 10001 to 10020,
			and employee number 110039 as a manager to all employees from 10021 to 10040.*/
 SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code, -- we use min cause more than one dept could be associated with an employee(it will . 
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID -- code to allow us select employee with emp_no 110022 from the dept_managers table
-- below, we join the employees and dept_managers table where no emp_no is greater than 20 
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A -- basically given a name to this Subset 'A'
-- we then proceed by inserting this entire code within the from statement of an even outer query
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
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
    LIMIT 20) AS B;   # Subset B  
    
/* Exercise: Task 1:
Starting your code with DROP TABLE, create a table called emp_manager (emp_no “ integer of 11, not null; dept_no “ CHAR of 4, null; manager_no “ integer of 11, not null).

Task 2:
Fill emp_manager with data about employees, the number of the department they are working in, and their managers.
Your query skeleton must be:
Insert INTO emp_manager SELECT
U.* FROM (A) UNION (B) UNION (C) UNION (D) AS U;

A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM). In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A), and employee number 110039 as a manager to all employees from 10021 to 10040 (this must be subset B).
Use the structure of subset A to create subset C, where you must assign employee number 110039 as a manager to employee 110022.
Following the same logic, create subset D. Here you must do the opposite - assign employee 110022 as a manager to employee 110039.
Your output must contain 42 rows.
Good luck!
*/

-- Solution
Drop table if exists emp_manager;
CREATE TABLE emp_manager (
    emp_no INT(11) Not Null,
    dept_no char(4) Null,
   manager_no int(11) Not Null);

Insert into emp_manager 
 Select U.* from  
 (SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
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
            (SELECT 
                    emp_no
                FROM
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
    
UNION SELECT 
    C.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
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
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D) As U; 
  
  -- query the above union set to view output
 Select * from emp_manager;  
  
/* SQL Self Join: - Applied when a table must join itself.
				  - if you'ld like to combine certain rows of a table with other rows of the same table, you need a self join.
                  - In self join, the two tables you will be using will be identical to the table you'll be usig in the self-join
                  - You can think of them as virtual projections of the underlying, base table
				  - The self join will reference both implied tables and will treat them as two separate tables in its operations
                  - The data comes from a single source
                  - Here, using aliases is obligatory. They help us distinguish the two virtual tables
                  - You can either filter both in the join or you can filter one of them in the where clause and the other one in the join*/
                  
-- Task: From the emp_manager table, extract the record data only of those employees who are managers as well.
SELECT 
    *
FROM
    emp_manager
ORDER BY emp_manager.emp_no;

SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
-- in the above, the connection is made with different columns of the base table
-- the above query connected the employee numbers of the first table e1 coinciding with managing numbers with the records of the second table e2

SELECT 
    e1.emp_no, e1.dept_no, e2.manager_no
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;

-- how do we obtain two rows of the data in our result

-- there are 2 ways to do this - using the select distinct
SELECT distinct
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
 -- Or using the where clause   
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager); -- where subquery returns the two row table

/* Using SQL views
View: A virtual table whose contents are obtained from an existing table(s), calles Base tables 
	  the retrieval happens through an SQL statement, incorporated into the view
SQL View: think of a view object as a view into the base table.
		  the view itself does not contain any real data; the data is physically stored in the base table.
          the view simply shows the data contained in the base table.*/
Select * from dept_emp;

Select 
emp_no, from_date, to_date, count(emp_no) As Num
from
dept_emp
group by emp_no
Having Num > 1;

-- to visualize only the period emcompassing the last contract of each employee

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
 
 SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no; -- base table showing last from and to date
    
-- check views session to see the view created
-- you can also click the DDL to see the view output
    
select * from employees.v_dept_emp_latest_date;

/* Why views?
- Imagine a database is used by a large web application being accessed by many users
- If you would like to allow each user to see this table, istead of typing the SQL code each time
- A view allows each user see the result set on their user space.
- A view also acts a shortcut for writing the same SELECT statement every time a new request has been made.
- It saves a lot of coding time and since it is written only once, It occupies no extra memory
-- acts as a dynamic table because it instantly reflects data and structural charges in the base tables 
Note:
	- Views are advantageous when used logically
    - They are not real, physical data sets, meaning we cannot insert or update the info that has already been extracted
    - They should be seen as temporary virtual data tables retrieving info from base tables.*/
   
-- Assignment: Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.
CREATE OR REPLACE VIEW v_managers_avg_salary AS
    SELECT 
        m.emp_no, Round(Avg(salary), 2) As Avg_salary
    FROM 
		salaries s
	Join
    dept_manager m
    On s.emp_no = m.emp_no;
    
