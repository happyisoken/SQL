/* Introduction to Stored Routines 
Routine: usual,fixed actions or series of actions repeated periodically

Stored Routine: An SQL statement or set of SQL statements that can be stored on the database server
wWhenever a user wants to use the query in question, thy can call, reference or invoke the routine

e.g think of a stored routine that contains a query that executes a very simple algorithm
	the algorithm checks all monty sales generated throughout a calendar year and returns the lowest of these values
    
Imagine there are 100 users of your database that need to run the code daily, would it mean they would need to run it everyday?
No! We could write a query that gives the desired output only once, then put it in a stored routine

Types of stored routine:
Stored procedures - procedures
Functions - user-defined functions
 

The MySQL syntax for stored procedures:
Semi-colons: they function as a statement terminator
			 they are also called delimiters
By typing Delimiter $$ or //, you will be able to use the dollar symbol as your delimiter. The semi-colon is no longer a delimiter

Syntax:
- paramenter represent certain values that the procedure will use to complete the procedure
- a procedure can also be created without the parameters but an empty parenthesis must always end it 
- what follows is the body of the parenthesis which must be enclosed between the BEGIN and the END Delimiters
- the body contains the query in question
- always remember to reset the delimiter */

# Stored Procedures – Example – Part 1
-- Example - We would device a non-parametric procedure that when applied, would return the first 1000 rows from the employees table*/
Use employees;

Drop procedure if exists select_employees;
 
 Delimiter $$
 Create procedure select_employees()
 Begin
 select * from employees
 limit 1000;
 End$$
 
 Delimiter ;

/* Stored Procedures – Example – Part 2 
ways to call a procedure */
call employees.select_employees();

-- Or
call employees.select_employees; -- this would work without the parenthesis.

/* or click on the lightning beside the stored procedure created to call the procedure
 - we can invoke the procedure by declaring the database in the beginning of the code block
 - to see the whole procedure, click on the wrench icon close to the procedure
 - this helps to update the structure of the procedure if needed
*/

# Assignment: Create a procedure that will provide the average salary of all employees. Then, call the procedure.
Delimiter $$
 Create procedure select_avg_salary()
 Begin
 select Avg(salary)  
 from salaries;
 End$$
 
 Delimiter ;

call select_avg_salary();

/* Another Way to Create a Procedure in MySQL: 
- Right click on the stored procedure label on the schema section, then click "create strored procedure"
- You would see a new tab containing a skeleton for creating a stored procedure. Rename the procedure
- Insert a short query ending with a semi-colon
- Click on the apply and then the finish button
- Then refresh the schema section */

-- Deleting a procedure: To delete/drop a procedure - drop procedure procedure_name;
Drop Procedure select_employees;

-- Or right click on the stored procedure in the schema section and select 'Drop Now'

/* Stored Procedures with an Input Parameter
A stored routine - can perform a calculation that transforms an input value into an output value.
Stored procedures - can take an input value and then use it in the query(s), written in the body of the procedure
- this value is represented by the IN parameter
- after that calculation is ready, a result will be returned*/

-- Example: say we want a program that returns the firstname, lastname, start and end of the contract
Drop procedure if exists emp_salary;
 
 Delimiter $$
 Use employees $$
 Create procedure emp_salary(IN p_emp_no Integer) -- specify the name of the column we want to use as our IN parameter
 Begin
 select 
 e.first_name, e.last_name, s.salary, s.from_date, s.to_date
 from 
 employees e
 Join
 salaries s ON e.emp_no = s.emp_no
 where
 e.emp_no = p_emp_no;
 End$$
 
 Delimiter ;
 
 -- To call the procedure, click on lightning on the stored procedure section and enter an employee number or
 call emp_salary(11300);

-- execute it from the stored procedures part of the schema section
 -- a window asking for emp_no pops up
 -- input a value of 11300 and we see a list of all 5 contracts Lilia Fontet ever had.
 
-- procedures with one input parameter can be used with aggregate functions too

-- To check the Employees Average salary
Drop procedure if exists emp_avg_salary;

Delimiter $$
 Use employees $$
 Create procedure emp_avg_salary(IN p_emp_no Integer)
 Begin
 select 
 e.first_name, e.last_name, AVG(s.salary)
 from 
 employees e
 Join
 salaries s ON e.emp_no = s.emp_no
 where
 e.emp_no = p_emp_no;
 End$$
 
 Delimiter ;
 
 -- invoking the procedure
 call employees.emp_avg_salary(11300);

/* Stored Procedures with an Output Parameter - This will represent the variable containing the output value of the operation executed by the query of the stored procedure */

-- To check the Employees Average salary Out
Drop procedure If exists emp_avg_salary_out;

Delimiter $$
 Create procedure emp_avg_salary_out(IN p_emp_no Integer, out p_avg_salary Decimal(10, 2))
 Begin
 select 
AVG(s.salary)
 Into p_avg_salary from -- everytime you create a procedure containing both an IN and OUT parameter, use the SELECT-INTO structure
 employees e
 Join
 salaries s ON e.emp_no = s.emp_no
 where
 e.emp_no = p_emp_no;
 End$$
 
 Delimiter ;
 
 call employees.emp_avg_salary_out(11300, @p_avg_salary);
 
 -- Assignment: Create a procedure called "emp_info" that uses as parameters the first and the last name of an individual, and returns their employee number.
 Drop procedure if exists emp_info;

DELIMITER $$

CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)

BEGIN

SELECT
e.emp_no
INTO p_emp_no FROM
employees e
WHERE
e.first_name = p_first_name
AND e.last_name = p_last_name;

END$$
#emp_info
DELIMITER ;
 
 call employees.emp_info('Aruna', 'Journel', @p_emp_no);
 
 /* Variables 
 When defining a program, such as a stored procedure for instance, we can say we are using 'parameters'
 - 'parameters' are a more abstract term 
 Once the structure has been solidified, it will then be applied to the database.alter
 The input value inserted is referred to as the 'argument'
 While the obtained output value is stored in a 'variable'. 
 
 Create procedure - argument (input) -----> variable (output) 
 To create a variable whose value equals to the calculation executed by the procedure created earlier
 1. create a variable 
	- use the set keyword
    - use the @ sign in front of the variable name preceded by 'v_'
    - set the value of the variable which can be any number but use preferably a 0
-- set is the mysql keyword that allows to create a variable

 2. extract a value that will be assigned to the newly created variable (call the procedure) 
	- Call the procedure with certain input and output values 
    - In the first position, indicate an input value e.g employee no 
    - In the second position, designate the place where the output value can be stored i.e result obtained by running the procedure e.g v_avg_salary
 
 3. ask the software to display the output of the procedure - by selecting the variable just created
 */
 set @v_avg_salary = 0;
call employees.emp_avg_salary_out(11300, @v_avg_salary);
select @v_avg_salary;
-- you have to run all 3 codes from top to bottom to get an output

# Assignment
-- Task 1: Create a variable, called "v_emp_no", where you will store the output of the procedure you created in the last exercise.
set @v_emp_no = 0;

-- Task 2: Call the same procedure, inserting the values "Aruna" and "Journel" as a first and last name respectively.
call employees.emp_info('Aruna', 'Journel', @v_emp_no);

-- Task 3: Finally, select the obtained output
select @v_emp_no;

/* User - defined functions in MySQL
The difference between stored procedures and functions
- No OUT parameters to define between the parentheses after the object's name
- All parameters are IN, and since this is well known, you need not explicitly indicate it with the word, 'IN'

- Although there are no out parameters, there is a 'return value' 
- The return value is obtained after running the query contained in the body of the function
- It can be of any data type */

Use employees;
Drop function  If exists f_emp_avg_salary;

Delimiter $$
 Create function f_emp_avg_salary (p_emp_no Integer) Returns Decimal(10, 2) -- indicate a parameter that will be within the parenthesis but the Keyword 'Returns' must be written outside the parenthesis with data type
 Begin
 
 Declare v_avg_salary Decimal(10,2); -- Declare is used to create variablesl Then indicate the name and the data type of the variable
									 -- the data type of the variable must correspond to the data type used in the returns statement 
SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
 Return v_avg_salary; -- this line must not be omitted and must be set to satisfy mysql syntax
 End$$
 
 Delimiter ;
 
 -- we cannot call a function, we select it indicating an input value as seen below
 
 Select f_emp_avg_salary(11300);
 
 /* Assignment: Create a function called "emp_info" that takes for parameters the first and last name of an employee, 
 and returns the salary from the newest contract of that employee.
Hint: In the BEGIN-END block of this program, you need to declare and use two variables - 
v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.
Finally, select this function. */

Drop function  If exists f_employees_emp_info;

Delimiter $$
 Create function f_employees_emp_info (p_first_name Varchar (255), p_last_name Varchar (255)) Returns Decimal(10, 2)
 Deterministic
 Begin
 
 Declare v_max_from_date Date;
 Declare v_salary Decimal(10, 2);
 
SELECT 
    MAX(from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;

SELECT 
    s.salary
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;
 Return v_salary; 
 End$$
 
 Delimiter ;
  
 select f_employees_emp_info('Parto', 'Bamford');
 
 /* Stored routines – Conclusion 
 
Difference between stored procedure and user defined functions
 Technical Differences
 - Stored proecdure does not return a value while user defined function returns a value
 - Stored proecdure CALLs the procedure while user defined function SELECTs the function
 Conceptual differences
 - Stored proecdure can have multiple OUT parameters while user defined function can return a single value only
 
 Therefore, if you need to obtain more than one value as a result of a calculation, use a procedure
 But, if you need just one value to be returned, use a function.
 Rather than use Create procedure(in..., Out...) just use a function
 How about involving an INSERT, UPDATE or a DELETE statement?
 - in those cases, the operation */

 

 