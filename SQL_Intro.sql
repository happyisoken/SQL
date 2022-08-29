/* Welcome to SQL: 
SQL is structure Query Language.
Query: A piece of code inducing the computer to execute a certain operation that will deliver the desired output.
	   used to manipulate data within a database
Why study SQL:
1. It is a programming language specifically designed for working with databses.
2. It allows one write queries that the computer can execute and then provide database insights in return
3. It allows one create, manipulate and share data from relational database Mgt systems
4. It's syntax is intuitive and easy to learn.
5. It is used for business problems involving the processing of large amounts of data.
6. It is used to solve sophisticated tasks.
7. It is powerful in completing complex tasks.
MySQL - Database Management system
Why MySQL
1. It is reliable, mature and open-source(free),
2. It is used by many institutions and companies including Facebook, Youtube, dropbox, twitter, printerest and LinkedIn

Introduction to databases
Data values makes up a record/row. A record is each entry that exists in a table. It corresponds to a row of the table.
Field - A column in a table containing specific information about every record in the table.
Stored tabular data - data stored in tabular form.
Relational algebra allows us to retrieve data efficiently.
A few related table form a relational database.
Entity: the smallest unit that can contain a meaningful set of data.
Rows - Horizontal entity or entity instance. 
Columns - Vertical entity
Entity - Database object

SQL LANGUAGES
SQL as a declarative language
 Types of programming
 - Procedural - How you want the job done
 - Object-oriented
 - Declarative - What result to obtain
 - Functional
SQL is declarative (nonprocedural) - not focused on how you want it done but on what result to obtain

SQL's Syntax: comprises several types of statments taht allows you to perform various commands and operations.
Main components of SQL's Syntax
1. Data Definition Language (DDL)
2. Data Manipulation Language (DML)
3. Data Control Language (DCL)
4. Transaction Control Language (TCL)

DATA DEFINITION LANGUAGE (DDL)
It is a set of statements taht allows the user define/modify data structures and objects, such as tables
The CREATE statement: used for creating entire databases & database objects as tables
The ALTER statement: Used when altering existing objects E.g Add, Remove or Rename
The DROP Statement: Used to delete an entire table
The RENAME Statement: Allows you to rename an object
The TRUNCATE statement: Instead of removing an entire table through DROP, we can remove the data and continue to have the table as an object in the database.

SQL keywords:
Add. Create. Alter etc
Keywords in SQL cannot be variabe names.
Objects or databases cannot have names that coincide with SQL keywords.
ADD - Adds a column. It is frequently used with the alter statement.
Keywords = Reserved words: They cannot be used when naming objects.

DATA MANIPULATION LANGUAGE (DML):
The SELECT statement: used to retrieve data from database objects, like tables
Select *: delivers the entire content of a table
The INSERT statement: used to insert data into tables i.e add more records/rows into tables
It goes with the keywords into and values. 
The UPDATE statement: allows you to renew existing data of your tables
The DELETE statement: Functions similarly to the TRUNCATE statement
TRUNCATE vs DELETE
TRUNCATE - allows us to remove all the records contained in a table.
DELETE - you can specify precisely what you would like to be removed.
 Summary of the DML
 - select... from
 - insert into... values
 - update...set...where
 - delete... from...where
 
DATA CONTROL LANGUAGE (DCL)
The GRANT and REVOKE statements - allows us to manage the rights users have in a database
The GRANT statement: gives (or grants) certain permission to users
					 one can grant a specific type of permission, like complete or partial
Database admonistrators: people who have complete rights to a database.
						 they can grant access to users and can revoke it.
The REVOKE clause - used to revoke permissions and privileges of database users.
					the exact opposite of GRANT

TRANSACTION CONTROL LANGUAGE (TCL)
Not every change you make to a database is saved automatically
The COMMIT statement - related to INSERT, DELETE, UPDATE
					   saves changes you have made.
                       saves the transaction in the database.
                       changes cannot be undone. 
                       will let other users have access to the modified version of the database.
                       committed states can accrue i.e can be used several times. 
The ROLLBACK clause - the clause that will let you make a step back (undo changes you dont want saved permanently) 
                      the last change(s) made will not count.
                      reverts to the last non-committed state. 
SQL Syntax
DDL - creation of data
DML - manipulation of data
DCL - assignment and removal of permissions to use data
TCL - saving and restoring changes to a database */
