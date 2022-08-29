/* Types of MySQL Variables
Scope = Visibility: it is the region of a computer program where a phenomenon such as variable is considered valid.
A variable could be relevant for a specific SQL statement only or it could be important for all the connections on the server.
  Types:
1. Local variables
2. Session variables
3. Global variables 

LOCAL VARIABLES: a variable that is visible only in the Begin - End block in which it was created.*/
-- MySQL variable
  set @v_avg_salary = 0;
call employees.emp_avg_salary_out(11300, @v_avg_salary);
select @v_avg_salary;

-- Example of Local Variable when outside the scope of MySQL
Drop function  If exists f_emp_avg_salary;

Delimiter $$
 Create function f_emp_avg_salary (p_emp_no Integer) Returns Decimal(10, 2) 
 Deterministic
 Begin
 
 Declare v_avg_salary Decimal(10,2); -- Declare is a keyword that can be used when creaating local variables only
									 
SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
 Return v_avg_salary; -- v_avg_salary cannot be accessed from outside this block
 
 End$$
 
 Delimiter ;
 
 select v_avg_salary; -- Error! This means variable is unknown to MySQL at this stage
					  -- the statement is beyond the scope of the local variable at this stage 
 -- within the scope
 Drop function If exists f_emp_avg_salary;

Delimiter $$
 Create function f_emp_avg_salary (p_emp_no Integer) Returns Decimal(10, 2) 
 Deterministic
 Begin
 
 Declare v_avg_salary Decimal(10,2); -- Declare is a keyword that can be used when creaating local variables only

Begin
	Declare v_avg_salary_2 Decimal(10,2);									 
End;

SELECT 
    AVG(s.salary)
INTO v_avg_salary_2 FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
 Return v_avg_salary_2; 
 
 End$$
 
 Delimiter ;
 
 select v_avg_salary; 
 
 /* SESSION VARIABLES
 Session variable: a series of information exchange interractions or a dialogue between a computer and a user 
				   E.g. a dialogue between the MySQ server and a client application like My SQL workbench.
A session begins at a certain point in time and terminates at another later point. 
Steps:
1. set up a connection
2. establish a connection
3. the workbench interface will open immediately
4. end a connection
there are certain sql objects that are valid for specific 

- since we are in the same session, we can open a new tab and select the same variable and get the output
- Opening a new session/connection and running the select statement would give a null output

a variable that exists
*/

Set @s_var1 = 3;

select@s_var1; 

/* GLOBAL VARIABLES: 
 - they apply to all connections related to a specific server
 - to indicate that we are creating a global variable, we use 'set global variable_name = value'
 - we can also use set @@global.variable_name = value
 - we cannot just set any variable as global
 - a specific group of predefined variable in MySQL is suited for this job, they are called system variables.
 
 Example of system variables are:
.max_connections() - indicates the maximum number of connections that can be established at a certain point in time
.max_join_size() - indicates the maximum memory space allocated for joins created by a certain connection
 */

Set Global max_connections = 1000; -- sets up to 1000 connections

Set @@global.max_connections = 1; -- sets up to 1 connection

/* User – Defined vs System Variables
Variables in MySQL can be categorized according to the way they have been created
1. User defined - variables are set by the user manually
				 E.g Local variables are user defined only
2. System - variables are pre-defined by the system on the MySQL server
		  - Global variables are only system variables.
          - only system variables can be set as global variable
          
- Session variables can be both user-defined and system variables but there are limitations to this-

 a user can define a local variable or a session variable 
 system variables can be set as */

set session max_connections = 1000; -- returns an error cause some of the system variables can be defined as global only and max_connections is one 
set session sql_mode = 'no_zero_date'; -- sql mode can help us adjust workbench settings
set global sql_mode = 'no_zero_date'; -- could be set as global or session variable 
Set @@global.max_connections = 1;

/* MySQL Indexes: The index of a table works like the index of a book
- data is taken from a column of the table and is stored in a certain order in a distinct place called an index
- the larger a database is, the slower the process of finding the record(s) you need
- For a large database,we can use an index that will increase the speed of searches related to a table
- the parenthesis in the syntax, indicates the column names on which our search will be based.
- choose columns so your search will be optimised */
-- Example: sort people on the employees tables according to their hire_date
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';
    
Create index i_hire_date On employees(hire_date); 

-- Composite indexes - they apply to multipe columns, not just a single one.
-- carefuly pick the columns that would optimize your search

# using a composite index, select all employees bearing the name 'Georgi Facello'
Drop index i_composite On employees;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';

-- create the composite index
create index i_composite On employees(first_name, last_name);
-- then re-run the  select statement - it should return quicker

/* Primary and  unique keys are MySQL indexes
-- they represent columns on which a prson would typically base their search
There are 2 ways to ask workbench to display a list with the indexes in use
	1. open info section on the database - select the index tab to see a list of all indexes in the Database
	2. you can also check the indexes related to a specific table.

 Or type and run code below */

Show index from employees from employees;
show index from employees; --  this could be ommitted

/*  In conclusion, SQL specialists are always aiming for a good balance between the improvement of speed search & the resources used for its execution
- An index occupies memory space and could be redundant unless it can contribute to a quicker check.
For small datasets - the cost of having an index might be higher than the benefits
For large datasets - a well-optimized index can make a positive impact on the search process */

-- Assignment
-- Task 1: Drop the i_hire_date index.
Drop index i_hire_date on employees;

-- Task 2:
-- Select all records from the salaries table of people whose salary is higher than $89,000 per annum.
-- Then, create an index on the salary column of that table, and check if it has sped up the search of the same SELECT statement.

Drop index i_salary on salaries; -- had to drop the index to re-create it
SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;
    
create index i_salary on salaries(salary);
-- then re-run the select statement. After creating the index, the search time for the select statement will be shorter.

/* The CASE Statement */
-- Example
SELECT 
    emp_no,
    first_name last_name,
    CASE
        WHEN gender = 'M' THEN 'Male' -- If value is M, it returns M if male. Else, return Female
        ELSE 'Female'
    END AS Gender
FROM
    employees;

-- another way to re-write the case
SELECT 
    emp_no,
    first_name last_name,
    CASE gender -- add the gender to the case statement (we obtain same result)
        WHEN 'M' THEN 'Male' 
        ELSE 'Female'
    END AS Gender
FROM
    employees;
    
-- the above technique wont work in all cases though
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE 
        WHEN dm.emp_no Is not Null then 'Manager'
        ELSE 'employee'
    END AS is_manager
FROM
    employees e
    Left Join
    dept_manager dm On dm.emp_no = e.emp_no
    where
    e.emp_no > 109990; 
    
-- re-writing the query
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE dm.emp_no
        WHEN not Null then 'Manager'
        ELSE 'employee'
    END AS is_manager
FROM
    employees e
    Left Join
    dept_manager dm On dm.emp_no = e.emp_no
    where
    e.emp_no > 109990;
  
  -- another example using the If
  SELECT 
    emp_no,
    first_name,
    last_name,
    If(gender = 'M', 'Male', 'Female') As gender -- with the If statement, 'M' returns male. Else, it will return Female but you do not have to indicate the 'F'
	from
    employees; -- same value as the case statement
    
    -- However, the 'IF' statement has some limitations compared to case
    -- with case, with multiple columns returns, not just a single one

-- Example
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    Max(s.salary) - Min(s.salary) as salary_difference,
     CASE 
        WHEN Max(s.salary) - Min(s.salary) > 30000 Then 'Salary was raised by more than $30000'
        WHEN Max(s.salary) - Min(s.salary) between 20000 and 30000 Then 
									'Salary was raised by more than $20000 but less then $30,000'
        ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM
	dept_manager dm
    Join
    employees e on e.emp_no = dm.emp_no
    Join
    salaries s On s.emp_no = dm.emp_no
    Group by
    s.emp_no;
    
 /*Assignment
Task 1:
Similar to the exercises done in the lecture, obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. 
Create a fourth column in the query, indicating whether this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee.

Task 2:
Extract a dataset containing the following information about the managers: employee number, first name, and last name. 
Add two columns at the end one showing the difference between the maximum and minimum salary of that employee, 
and another one saying whether this salary raise was higher than $30,000 or NOT.

If possible, provide more than one solution.

Task 3:
Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, 
called current_employee saying Is still employee if the employee is still working in the company, or Not an employee anymore if they arent.

Hint: You'll need to use data from both the employeesâ€™ and the â€˜dept_emp table to solve this exercise. */   

-- Solution - Task 1
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE 
        WHEN dm.emp_no is not Null then 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
    Left Join
    dept_manager dm On dm.emp_no = e.emp_no
    where
    e.emp_no > 109990;
    
   -- Solution - Task 2 
    SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    Max(s.salary) - Min(s.salary) as salary_difference,
     CASE 
        WHEN Max(s.salary) - Min(s.salary) > 30000 Then 'Salary was raised by more than $30000'
        ELSE 'Salary raise less than $30,000'
    END AS salary_increase
FROM
	dept_manager dm
    Join
    employees e on e.emp_no = dm.emp_no
    Join
    salaries s On s.emp_no = dm.emp_no
    Group by
    s.emp_no;

-- another way to do this 
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,'Salary was raised by more than $30000', 'Salary raise less than $30,000') AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;
    
-- Solution - Task 3    
    SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    Case
    When Max(de.to_date) > sysdate() then 'is still employed' 
    Else 'not an employee anymore'
    End as current_employee
FROM
    employees e
     Join
    dept_emp de On e.emp_no = de.emp_no
    group by de.emp_no
    Limit 100;
    
    Select sysdate();
    
-- How to use the Windows Command Prompt (Beginners Guide)