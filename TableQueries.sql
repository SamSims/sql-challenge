--List the employee number, last name, first name, sex, and salary of each employee 
select e.emp_no,e.first_name,e.last_name,e.sex,s.salary
from "Employees" as e
join "Salaries" as s 
on e.emp_no= s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986
select first_name, last_name, hire_date
from "Employees"
where hire_date between '1/1/1986' and '12/31/1986';

--List the manager of each department along with their 
--department number, department name, employee number, last name, and first name
select dm.dept_no, d.dept_name, e.emp_no, e.first_name,e.last_name
from "DeptManager" as dm
join "Departments" as d on dm.dept_no= d.dept_no
join "Employees" as e
on dm.emp_no = e.emp_no; 

--List the department number for each employee along with that employee’s 
--employee number, last name, first name, and department name
select d.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
from "Employees" as e
join "DeptEmp" as de on e.emp_no= de.emp_no
join "Departments" as d
on de.dept_no= d.dept_no;

--List first name, last name, and sex of each employee whose 
--first name is Hercules and whose last name begins with the letter B 
select first_name, last_name, sex
from "Employees"
where first_name = 'Hercules' and last_name like 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name
select emp_no, last_name, first_name
from "Employees"
where emp_no in (select emp_no from "DeptEmp" where dept_no in (select dept_no from "Departments" where dept_name='Sales'));

--List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name from "DeptEmp" as de
join "Employees" as e on e.emp_no= de.emp_no
join "Departments" as d
on de.dept_no= d.dept_no
where de.dept_no in(select dept_no from "Departments" where dept_name in('Sales','Development'));

--List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name)
select last_name, count(last_name) from "Employees"
group by last_name
order by count(last_name) desc; 