-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- create the Departments table
drop table if exists "Departments";
CREATE TABLE "Departments" (
    "dept_no" char(4)   NOT NULL,
    "dept_name" varchar(20)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

--create the Titles table
drop table if exists "Titles";
CREATE TABLE "Titles" (
    "title_id" char(5)   NOT NULL,
    "title" varchar(20)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

-- create the Employees table
drop table if exists "Employees";
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

--create the Salaries table
drop table if exists "Salaries";
CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no","salary"
     )
);

--create the junction table of employees and departments
drop table if exists "DeptEmp";
CREATE TABLE "DeptEmp" (
    "emp_no" int   NOT NULL,
    "dept_no" char(4)   NOT NULL,
    CONSTRAINT "pk_DeptEmp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

--create the junction table of departments and managers
drop table if exists "DeptManager";
CREATE TABLE "DeptManager" (
    "dept_no" char(4)   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_DeptManager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

--create a foriegn key in the Employees table refrencing the Titles table
ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

--create a foreign key in the Salaries table refrencing the Employees table
ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--create a foreign key in the DeptEmp table refrencing the Employees table
ALTER TABLE "DeptEmp" ADD CONSTRAINT "fk_DeptEmp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--create a foreign key in the DeptEmp table refrencing the Departments table
ALTER TABLE "DeptEmp" ADD CONSTRAINT "fk_DeptEmp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

--create a foreign key in the DeptManager table refrencing the Departments table
ALTER TABLE "DeptManager" ADD CONSTRAINT "fk_DeptManager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

--create a foreign key in the DeptManager table refrencing the Employees table
ALTER TABLE "DeptManager" ADD CONSTRAINT "fk_DeptManager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");
