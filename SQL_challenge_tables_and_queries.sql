--Import each CSV file into the corresponding SQL table.
--
DROP TABLE if exists titles CASCADE;

CREATE TABLE titles(
	title_id VARCHAR NOT NULL PRIMARY KEY,
	title VARCHAR NOT NULL);
	
Select * from titles;

--
DROP TABLE if exists departments CASCADE;

CREATE TABLE departments(
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR NOT NULL);
	
SELECT * FROM departments;

--

DROP TABLE if exists employees CASCADE;

CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	birth_date DATE,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE);
	
SELECT * FROM employees;

--

DROP TABLE if exists salaries;

CREATE TABLE salaries(
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT);
	
SELECT * FROM salaries;

--

DROP TABLE if exists dept_manager;

CREATE TABLE dept_manager(
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no));
	
SELECT * FROM dept_manager;

--

DROP TABLE if exists dept_emp;

CREATE TABLE dept_emp(
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no));
	
SELECT * FROM dept_emp;

--



--1.)List the following details of each employee: employee number, 
--last name, first name, sex, and salary.
SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.sex,
	salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no;




--2.)List first name, last name, and hire date for employees who 
--were hired in 1986.
--https://stackoverflow.com/questions/58885929/how-to-answer-this-question-list-employees-who-were-hired-in-1986
SELECT first_name,
	last_name,
	hire_date
FROM employees
WHERE extract(year from hire_date) = 1986;

--3.)List the manager of each department with the following 
--information: department number, department name, the manager's 
--employee number, last name, first name.
SELECT departments.dept_no,
	departments.dept_name,
	dept_manager.emp_no,
	employees.last_name,
	employees.first_name
FROM departments 
INNER JOIN dept_manager ON
departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON
employees.emp_no = dept_manager.emp_no;


--4.)List the department of each employee with the following 
--information: employee number, last name, first name, and department name.
SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no;

--5.)List first name, last name, and sex for employees whose first 
--name is "Hercules" and last names begin with "B."
SELECT first_name,
	last_name,
	sex
FROM employees
WHERE last_name LIKE ('B%')
AND first_name = 'Hercules';

--6.)List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.
SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name LIKE ('Sales');


--7.)List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name LIKE ('Sales')
OR departments.dept_name LIKE ('Development');


--8.)In descending order, list the frequency count of employee 
--last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;




