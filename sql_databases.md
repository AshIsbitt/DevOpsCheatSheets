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
## Complex databases
(IE any database with multiple tables and relationships between them)


```sql
--Add a foriegn key field:
CREATE TABLE tbl2 (
    tbl2_key INT PRIMARY KEY,
    FOREIGN KEY(other_tbl) REFERENCES employee(tbl1_key) ON DELETE SET NULL
);

-- Update a key to be a foreign key once it's already been created
ALTER TABLE employee
    ADD FOREIGN KEY(branch_id)
    REFERENCES branch(branch_id)
    ON DELETE SET NULL;

-- Composite primary key:
CREATE TABLE tbl3 (
    field_1 INT,
    field_2 INT,
    PRIMARY KEY (field_1, field_2), -- Primary key that's also a foreign key
    FOREIGN KEY(field_2) REFERENCES tbl2(tbl2_key) ON DELETE SET NULL
);
```

`ON DELETE CASCADE` is another option for the foreign key. This does something different:

Handling a combination of primary and foreign keys in two tables bound together
is something that needs to be handled differently. TLDR if you're setting a field
that's a Pkey elsewhere, set it to NULL in your INSERT INTO statements

```sql
-- THe two NULL fields here are Fkeys
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

-- Set the first NULL value in the first statement to the record of the second
-- INSERT statement
UPDATE employee
SET branch_id = 1
WHERE emp_id - 100;
```

## More complex queries

```sql
-- Output a column with a different name
SELECT first_name AS forname, last_name AS surname -- AS sets an alias for the scope of this query
FROM employee;

-- Find unique elements in a column
SELECT DISTINCT sex
FROM employee;

-- Find the number of employees
SELECT COUNT(emp_id)  -- Get the count of employee_id 
FROM employee;
```

## SQL Functions

```sql
-- Find the number of female employees born after 1970
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_date > '1970-01-01';

-- Find the average of all employee's salaries
SELECT AVG(salary)
FROM employee

SELECT SUM(salary) -- How much the company is spending here
FROM employee

-- FInd out how many males and females there are
SELECT COUNT(sex)
FROM employee
GROUP BY sex -- group the info by this value - data aggregation
```

## Wildcards
You can use `LIKE` basically as a comparator for strings 
`%` = any characters
`_ ` = any single character

This is a super simplified version of regex

```sql
-- FInd any clients who are an LLC
SELECT *
FROM client
WHERE client_name LIKE '%LLC'; -- Any company who's name ends in 'LLC' 

-- Find branch suppliers who are in the label business
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '% Label%'; -- Any characters before 'label' and any chars after

-- Find any employee born after october
-- Dates are stored as YYYY-MM-DD
SELECT *
FROM employee
WHERE birth_date LIKE '____-10%';
-- '____-10%' = 4 Y chars (the four underscores) then a dash, then the number 
-- 10, and anything after that
```

## Union
These are special operators that can combine different `SELECT` statements
- Unions have to have the same number of columns on both sides
- They also have to be the same data type

```sql
-- Find a list of employee and branch names
SELECT first_name AS Company_names
FROM employee
UNION 
SELECT branch_name
FROM branch;
UNION
SELECT client_name
FROM clients

-- find a list of all client and branch suppliers
SELECT client_name, client.branch_id
FROM client
UNION
SELCT supplier_name branch_supplier.branch_id
FROM branch_supplier
```

## Joins
These are used to combine rows on tables based on a related column on both 

```sql
-- Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id; -- specify which columns are the same data

```
Instead of using `JOIN`, you can use `LEFT JOIN` to use all the rows from the 
left table (employee), but the specified column from the right table also appears
and is filled out as NULL otherwise (example using left join below)

```
mysql> SELECT employee.emp_id, employee.first_name, branch.branch_name 
FROM employee 
LEFT JOIN branch 
ON employee.emp_id = branch.mgr_id;
+--------+------------+-------------+
| emp_id | first_name | branch_name |
+--------+------------+-------------+
|    100 | David      | Corporate   |
|    101 | Jan        | NULL        |
|    102 | Michael    | Scranton    |
|    103 | Angela     | NULL        |
|    104 | Kelly      | NULL        |
|    105 | Stanley    | NULL        |
|    106 | Josh       | Stamford    |
|    107 | Andy       | NULL        |
|    108 | Jim        | NULL        |
+--------+------------+-------------+
9 rows in set (0.00 sec)
```

You can also use a RIGHT JOIN to get all the records from the right table Instead
```
mysql> select employee.emp_id, employee.first_name, branch.branch_name from employee right join branch on employee.emp_id = branch.mgr_id;
+--------+------------+-------------+
| emp_id | first_name | branch_name |
+--------+------------+-------------+
|    100 | David      | Corporate   |
|    102 | Michael    | Scranton    |
|    106 | Josh       | Stamford    |
|   NULL | NULL       | Buffalo     |
+--------+------------+-------------+
4 rows in set (0.00 sec)
```

MySQL doesn't support the FULL OUTER JOIN feature, which will bring _all_ the 
data from both tables.

## Nested Queries
A query with another query embedded within to get more detailed results

```sql
-- find names of all employees who have sold more than 30k to a single client
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
    FROM works_woth
    WHERE works_with.total_sales > 30000
);
```



