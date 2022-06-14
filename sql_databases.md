# SQL Databases

Install guide I'm following for MacOS: https://flaviocopes.com/mysql-how-to-install/
TLDR: use Brew
```
mysql.server start
mysql -u <user> -p <pass>
```

I set up `root` as the user and no password for local REPL usage

## What is a database
SQL is used to interact with Relational Database Management Systems (RDBMS)

Database schema is a combination of all the tables and relations a database can
store

What is a database?
    - Any collection of related information
        - Phone book
        - Shopping list
        - Todo list
        - Facebook user base
    - Databases can be stored in different ways
        - on paper
        - in your mind
        - powerpoints
        - comments section

Computers are great at keeping track of large amounts of information

Database Management System - special software that helps users create/maintain a database
    - makes it easy to manage large amounts of information
    - handles security
    - backups
    - importing/exporting data
    - concurrency
    - interacts with software/programming languages

Interacting with the database covers Creating, Reading, Updating, Deleting information (CRUD)

Relational DBs - organises data into columns and rows in tables with unique keys
non-relational DBs - key-value stores, documents (JSON/XML etc), graphs, flexible tables

Unique data - Ids, usernames etc.

non-relational DBMS - MongoDB, dynamoDB, Firebase, apache cassandra
These tend to be implementation-specific, they don't use a common SQL-like langauge

* Query - Requests made to the db for specific information - ex google search

## Tables and Keys
Example table:

|---------------------------------|
| *Student_ID | name  | major     |
|-------------|-------|-----------|
|  1          | kate  | bio       |
|  2          | jack  | english   |
|  3          | isla  | comp. sci |
|  4          | billy | sociology |
|---------------------------------|

The Student_ID is the primary key - it has to be unique for each row in this 
table. This doesn't have to be a number, it can be text - it just has to be a 
unique value. A Surrogate key is a primary key that has no real value outside
of the database, something that means nothing else. The above student id is an 
example of this

Foreign keys are columns that link you to other tables - they're the primary key
of another table that are used basically as a reference. These won't be unique
as you can have multiple entries in table 1 referring to the same record in 
table 2. A table can have multiple foriegn keys.

Composite key is when a table uses multiple columns as a primary key. For example
if a branch supplier table needs branch id and supplier id as multiple suppliers
can supply to multiple branches. 

## SQL Basics
Structured Query Language - a language used to interact with DMBS
    - you can use it to CRUD data
    - Create and manage Databases
    - design and create database tables
    - perform administrction tasks (security, user management, IO, etc)

There are different implementations out there - each one works ~slightly~ 
different

SQL is made up of four different 'parts' of the language
    - Data Query Language - used to create queries to get information out
    - Data Definition Language - used to define database layout/schemas
    - Data Control Language - used to control access/permissions etc
    - Data Manipulation Language - Used for inserting, updating, deleting data

### queries
A query is a set of instructions given to the DBMS to tell it what information
you want to retrieve. 

```sql
SELECT employee.name, employee.age
FROM employee
WHERE employee.salary > 3000;
```

## Databases and Tables
Each line of SQL ends in a `;`

Basic datatypes:
    - INT - any whole number 
    - DECIMAL(M,N) - M = total digits, N = digits after the decimal
    - VARCHAR(1) - string of text of length 1
    - BLOB - Binary Large OBject, used for storing data (images etc)
    - DATE - yyyy-mm-dd
    - TIMESTAMP - yyyy-mm-dd HH:MM:SS - used for recording when data was entered

There may be other data types depending on the type of SQL you use

Create database: `CREATE DATABASE my_db;`
View all databases - `SHOW DATABASES;`
Switch to use a specific DB: `USE my_db;`

```console
+--------------------+
| Database           |
+--------------------+
| information_schema |
| my_Db              |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.02 sec)
```

Create table: 

```sql
CREATE TABLE student ( 
    student_id INT PRIMARY KEY, 
    name VARCHAR(20), 
    major VARCHAR(20)
    -- Alternatively you can do PRIMARY KEY(student_id) to specify Pkey
); 
```

```console
mysql> DESCRIBE student;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| student_id | int         | NO   | PRI | NULL    |       |
| name       | varchar(20) | YES  |     | NULL    |       |
| major      | varchar(20) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)
```

Delete a table: `DROP TABLE tbl1;`

Edit a table after you've created it: `ALTER TABLE tbl1 ADD new_field DECIMAL(3,2);`
This will allow for numbers in the style of `1.23`

Remove specific column: `ALTER TABLE tbl1 DROP COLUMN new_field;`

### Constraints
These are other keywords you can use when creating a table that define rules
- `NOT NULL` This column cannot be empty/NULL
- `UNIQUE` - Value must be unique
- `DEFAULT 'foo'` - If it's left blank, set the value to `foo`
- `AUTO_INCREMENT` - This can increment an INT when not given 
    - really useful for Pkeys

```sql
CREATE TABLE student ( 
    student_id INT PRIMARY KEY, 
    name VARCHAR(20) NOT NULL, 
    major VARCHAR(20) UNIQUE
); 
```

```
mysql> DESCRIBE student;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| student_id | int         | NO   | PRI | NULL    |       |
| name       | varchar(20) | NO   |     | NULL    |       |
| major      | varchar(20) | YES  | UNI | NULL    |       |
+------------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)
```

## Inserting data
You have to list each piece of data in order of the columns you want them in

```sql
INSERT INTO tbl1 VALUES(
   1, -- student_id 
   'Jack', -- name
   'Bio' -- major
);
```

```console
mysql> INSERT INTO student VALUES(
    -> 1,
    -> 'jack',
    -> 'Bio'
    -> );
Query OK, 1 row affected (0.01 sec)
```

You can specify the rows to fill as well:
`INSERT INTO student(student_id, name) VALUES(4, 'kieron');`

THis will leave the empty fields filled with a NULL

## Updating and Deleting rows

```sql
UPDATE student -- table name 
SET major='bio'-- Define new value 
WHERE major='biology'; -- Specify current value to replace 

```
This can use any of the standard comparison operators
The `SET` and WHERE` don't have to check the same value. 
    IE you can change someone's major based on their student_id 

You can also use some boolean operators as well:

```sql
UPDATE student 
SET major='bioChem', name='bob' -- use commas here to update multple things
WHERE major='biology' OR major='Chemistry';
```

Deleting rows. It's the same as updaing but with a different first statement:

```sql
DELETE FROM student
WHERE student_id=5;
```

## Queries

These are the way to draw information back from the database with a powerful range
of parameters and other keywords you can combine for more information

```sql
SELECT *
FROM  student;

SELECT name, major -- you can specify fields
FROM student;

SELECT student.name, student.major -- THis sometimes is done for more information 
FROM student;

SELECT student.name, student.major 
FROM student
ORDER BY name; -- order alphabetically by the name field
--ORDER BY name DESC; -- use DESC to sort descending order 

SELECT student.name, student.major 
FROM student
ORDER BY student_id; -- you can sort by fields that aren't called too 

SELECT student.name, student.major 
FROM student
ORDER BY major, student_id; -- Multiple sorting rules 

SELECT * 
FROM student
LIMIT 2; -- Only get the top x results

SELECT * 
FROM student
WHERE major = 'Biology'; -- only return records that match this requirement (See WHERE above)

SELECT * 
FROM student
WHERE major <> 'Biology' -- <> is a NOT 

SELECT * 
FROM student
WHERE name IN ('claire', 'kate', 'mike'); -- If item in the list 
```



