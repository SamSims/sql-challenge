-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" char(4)   NOT NULL,
    "dept_name" varchar(20)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" char(5)   NOT NULL,
    "birt_date" date   NOT NULL,
    "first_name" varchar(20)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    "sex" char(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" char(5)   NOT NULL,
    "title" varchar(20)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no","salary"
     )
);

CREATE TABLE "DeptEmp" (
    "emp_no" int   NOT NULL,
    "dept_no" int   NOT NULL,
    CONSTRAINT "pk_DeptEmp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "DeptManager" (
    "dept_no" int   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_DeptEmp" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "DeptEmp" ADD CONSTRAINT "fk_DeptEmp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "DeptEmp" ADD CONSTRAINT "fk_DeptEmp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "DeptManager" ADD CONSTRAINT "fk_DeptManager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "DeptManager" ADD CONSTRAINT "fk_DeptManager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--List the employee number, last name, first name, sex, and salary of each employee 
select e.emp_no,e.first_name,e.last_name,e.sex,s.salary
from Employees as e
join Salaries as s 
on e.emp_no, s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986
select first_name, last_name, hire_date
from Employees
where hire_date = %1986;

--List the manager of each department along with their 
--department number, department name, employee number, last name, and first name
select dm.dept_no, d.dept_name, e.emp_no, e.first_name,e.last_name
from DeptManager as dm
join Departments as d, Employees as e
on dm.dept_no, d.dept_no dm.emp_no, e.empt; 

--List the department number for each employee along with that employee’s 
--employee number, last name, first name, and department name
select d.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
from Employees as e
join DeptEmp as de, Departments as d
on e.emp_no, de.emp_no, de.dept_no, d.dept_no;

--List first name, last name, and sex of each employee whose 
--first name is Hercules and whose last name begins with the letter B 
select first_name, last_name, sex
from Employees
where first_name = 'Hercules' and last_name = 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name
select emp_no, last_name, first_name
from Employees
where emp_no in (select emp_no from DeptEmp where dept_no in (select dept_no from Departments where dept_name='Sales'));

--List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name from DeptEmp
join Employees as e, DeptEmp as de, Departments as d
on e.emp_no, de.emp_no, de.dept_no, d.dept_no
where dept_no in(select dept_no from Departments where dept_name in('Sales','Development'));

--List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name)
select last_name, count(last_name) from Employees
list descending; 