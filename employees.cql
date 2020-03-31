DROP KEYSPACE IF EXISTS employees;
create keyspace if not exists employees with replication={'replication_factor': 3, 'class': 'SimpleStrategy'};
USE employees;

DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS salaries; 
DROP TABLE IF EXISTS employees; 
DROP TABLE IF EXISTS departments;

CREATE TABLE titles (
    emp_no      INT,
    title       TEXT,
    from_date   DATE,
    to_date     DATE,
    PRIMARY KEY (emp_no, title, from_date)
); 

CREATE TABLE departments (
    dept_no     TEXT,
    dept_name   TEXT,
    PRIMARY KEY (dept_no)
);

CREATE TABLE dept_manager (
   emp_no       INT,
   dept_no      TEXT,
   from_date    DATE,
   to_date      DATE,
   PRIMARY KEY (emp_no, dept_no)
); 

CREATE TABLE dept_emp (
    emp_no      INT,
    dept_no     TEXT,
    from_date   DATE,
    to_date     DATE,
    PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE salaries (
    emp_no      INT,
    salary      INT,
    from_date   DATE,
    to_date     DATE,
    PRIMARY KEY (emp_no, from_date)
) ; 

copy employees.titles (emp_no, title, from_date, to_date) from 'titles.csv' with delimiter=',' and header=false;

copy employees.departments (dept_no, dept_name) from 'departments.csv' with delimiter=',' and header=false;

copy employees.dept_emp (emp_no, dept_no, from_date, to_date) from 'dept_emp.csv' with delimiter=',' and header=false;

copy employees.dept_manager (emp_no, dept_no, from_date, to_date) from 'dept_manager.csv' with delimiter=',' and header=false;

copy employees.salaries (emp_no, salary, from_date, to_date) from 'salaries1.csv' with delimiter=',' and header=false;

copy employees.salaries (emp_no, salary, from_date, to_date) from 'salaries2.csv' with delimiter=',' and header=false;

copy employees.salaries (emp_no, salary, from_date, to_date) from 'salaries3.csv' with delimiter=',' and header=false;
