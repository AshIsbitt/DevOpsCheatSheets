# SQL Databases

Install guide I'm following for MacOS: https://flaviocopes.com/mysql-how-to-install/
TLDR: `use Brew`

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

