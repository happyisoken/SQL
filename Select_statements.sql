/*The Select statement: allows you to extract a fraction o	f the entire data set.
					  used to retrieve data from database objects, like tables
                      used to 'query data from a database. 
Syntax: Select column_1, column_2,...colum_n
		From table_name;
The FROM tells us which table to retreve data from
When extracting info, SELECT goes with FROM */

SELECT 
    first_name, last_name
FROM
    employees;

-- keywords are in light blue colour.
-- the beautify icon (Cntr + B), helps to organise your code better.
-- the * symbol is a wildcard character that means "all" and "everything"
SELECT 
    *
FROM
    employees;
    
-- To select the information from the "dept_no" column of the "departments" table.
SELECT 
    dept_no
FROM
    departments; 
    
-- Select all data from the "departments" table.
SELECT 
    *
FROM
    departments;

/* WHERE - this allows us to to set a condition upon which we will specify what part of the data to retrieve from the database
 Example - select all employees whose first name is Denis*/ 
 SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
 
 -- always remember to add '' or "" to a string
 -- the equality sign isn't used for mathematical expressions only
 
# Select all people from the "employees" table whose first name is "Elvis".
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';

/* The AND statement - allows us to combine two statements in the condition code block
					   allows us to narrow the output we would like to extract from our data
                       binds SQL to meet both conditions enlisted in the where clause simultaneously
= equal operator 
In SQL, there are many linking keywords & symbols, called operators, that can be used with the WHERE clause
E.g And, Or, In - Not In, Like - Not Like, Between ...and etc
Example: retrieve info of employes whose first name is Denis and are male*/
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';
  
  -- Retrieve a list with all female employees whose first name is Kellie.
  SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' And Gender = 'F'; 
    
/* The OR condition is set on the same column while the AND is set on different columns */ 
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' OR first_name = 'Elvis';
    
# First example    
SELECT 
    *
FROM
    employees
WHERE
    Gender = 'F' AND (first_name = 'Aruna' OR first_name = 'Kellie'); # use the paenthesis to separate the AND and OR statements

/* Operator Precedence:  An SQL stating that in the execution of a query, when both AND and OR is applied, the operator AND is applied first while the OR is applied second
						 Regardless of the order in which you use these operators, SQL will always start by reading the conditions around the AND operator 
                         AND > OR */
# Example
SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis'
        AND gender = 'M' OR gender = 'F';
        
 -- use a parenthesis to correct this; to retrieve a list of people with last name "Denis" independent of their gender.       
 SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');
-- always try to check the result obtained in the output.
        
/* The IN and NOT IN statements. */
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Cathie'
    OR first_name = 'Mark'
    OR first_name = 'Nathan';

-- writing in a quicker and more professinal way, use the IN operator
-- The IN operator allows SQL retrieve data named in the parenthesis if they exist in the table 
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie', 'Mark', 'Nathan');
    
-- using the NOT IN operator
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie', 'Mark', 'Nathan');
 # the NOT IN statement allows SQL extract records from the table, aside from those named in the parenthesis.
 
 -- Task 1: Use the IN operator to select all individuals from the employees table, whose first name is either Denis, or Elvis  
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis', 'Elvis');

-- Task 2: Extract all records from the employees table, aside from those with employees named John, Mark, or Jacob.    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John', 'Mark', 'Jacob');

/* LIKE - NOT LIKE
The % sign is a substitute for a sequence of characters.
 
Pattern matching - use the % to indicate the pattern
Mar% - retrieves data starting with Mar. 
%Mar - retrieves data ending with Mar. 
%Mar% - retrieves data where Mar is found in-between.*/

-- Mar% - retrieves a list of all names starting with Mar
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%'); 
    
 -- %ar - retrieves all the names ending with "ar" 
 SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%ar');
    
-- %ar% - two percentage signs around the designated letters, retrieves names where 'ar' is found somewhere in the individuals first name
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%ar%');
    
/* The underscore (_) is another symbol used for pattern matching
   It helps match a single character.
To fetch all names starting with "Mar" and written with 4 letters, type Mar_*/
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar_');

-- 1000_ retrieves data that begins with 1000 with one character after e.g 10005, 10007 etc     

-- NOT LIKE - gives the exact opposite of LIKE
  SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Ma%'); 
    
 -- unlike other SQL languages, MySQL is case insensitive. Smal or Capital letters obtain same output. 
    
# Task 1 - Retrieve a list with all employees who have been hired in the year 2000 (within the year 2000).   
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%'); 
    
# Task 2 - Retrieve a list with all employees whose employee number is written with 5 characters, and starts with "1000"
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_'); 
    
# Task 4 - select the data about all individuals, whose first name starts with "Mark"; specify that the name can be succeeded by any sequence of characters. 
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%Mark%');  
    
/* Wildcard Characters
Example of wild character are percetage symbol %,underscore_  and asterisk *. 
these are needed whenever we wished to put 'anything' on its place */

-- The * - delivers a list of all columns in a table 
 Select * from employees;
 
 -- The % - a substitute for a sequence of characters
 -- Task - Extract all individuals from the "employees" table whose first name contains "Jack".
 SELECT 
    * 
FROM
    employees
WHERE
    first_name LIKE ('%Jack%');
    
-- The _ helps you match a single character
-- Task - Extract another list containing the names of employees that do not contain "Jack"
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jack%');
    
/* Between ... And...: Helps us designate the interval to which a given value belongs
Example: Obtain a list of people hired between the 1/1/1990 and 1/1/2000 */
SELECT 
    *
FROM
    employees
WHERE
    hire_date between '1990-01-01'and '2000-01-01'; -- note that both that both dates will be included in the retrieved list of records

/* NOT BETWEEN ... AND - will refer to an interval composed of two parts:
 i. an interval below the irst value indicated
 ii. a second interval above the second value. */
 SELECT 
    *
FROM
    employees
WHERE
    hire_date Not between '1990-01-01'and '2000-01-01'; -- here, the 2 values are not included in the intervals

/* Note: Between is not only used for date values
		 It could also be applied to strings and numbers */
         
# Task 1: Select all the information from the "salaries" table regarding contracts from 66,000 to 70,000 dollars per year.
SELECT 
    *
FROM
    salaries
WHERE
   salary between '66000' and '70000';
   
 # Task 2 - Retrieve a list with all individuals whose employee number is not between "10004" and "10012"
 SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT between '10004' and '10012';
    
 # Task 3 - Select the names of all departments with numbers between "d003" and "d006
 SELECT 
    *
FROM
    departments
WHERE
    dept_no between 'd003'and 'd006';
 
 /* IS NOT NULL - used to extract values that are not null */ 
 SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL;

/* IS NULL - used to extract values that are null */
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL; 
-- result shows no output meaning that the database is brilliantly organised. No employees with missing first name.
    
-- Task: Select the names of all departments whose department number value is not null.  
 SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;
    
/* Other Comparison Operators:
= - equal to
> - greater than
>= - greater than or equal to
< - less than 
<= - less than or equal to 
<>, != - not equal or different from*/

-- retrieve a list of employees with frst name equal to Mark
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Mark'; 
    
-- retrieve a list of employees with frst name not equal to Mark
SELECT 
    *
FROM
    employees
WHERE
    first_name <> 'Mark'; 

-- OR
SELECT 
    *
FROM
    employees
WHERE
    first_name != 'Mark';
    
-- provide a list of employees hired after the 1st of January 2000
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';
    
-- to include the 1st of January 2000
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01';
    
-- to check if anybody was hired before the 1st of February 1985  
  SELECT 
    *
FROM
    employees
WHERE
    hire_date < '1985-02-01';

-- to include 1st of February 1985
    SELECT 
    *
FROM
    employees
WHERE
    hire_date <= '1985-02-01';
    
 # Task 1 - Retrieve a list with data about all female employees who were hired in the year 2000 or after
 SELECT 
    *
FROM
    employees
WHERE gender = 'F' AND hire_date >= '2000-01-01';

# Task 2 - Extract a list with all employees' salaries higher than $150,000 per annum.
SELECT 
    *
FROM
    salaries
WHERE
	salary > '150000';
      
/* select distinct: selects all distinct, different data values (does not duplicate) */
 SELECT DISTINCT 
    gender
FROM
    employees;
    
 # Task: Obtain a list with all different "hire dates" from the "employees" table. 
 SELECT DISTINCT 
    HIRE_DATE
FROM
    employees;
  


