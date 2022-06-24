---------------------------------------------------------------------------------------------------------------------
--Deliverable 1: 
---------------------------------------------------------------------------------------------------------------------
--The Number of Retiring Employees by Title.
SELECT e.emp_no,
	e.first_name, 
	e.last_name, 
	ti.title, 
	ti.from_date, 
	ti.to_date	
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;
	
-- The Number of Retiring Employees by Title (No Duplicates).
SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title

INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- The number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count DESC;

-----------------------------------------------------------------------------------------------------------------------------
--Deliverable 2: 
-----------------------------------------------------------------------------------------------------------------------------
--The Employees Eligible for the Mentorship Program.
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, ti.from_date DESC;

-----------------------------------------------------------------------------------------------------------------------------
--Deliverable 3: 
------------------------------------------------------------------------------------------
-- How many roles will need to be fill per title and department?
SELECT DISTINCT ON (emp_no) e.emp_no, 
			    e.first_name, 
			    e.last_name, 
			    e.birth_date, 
			    de.from_date, 
			    de.to_date, 
			    t.title
INTO employees_leaving
FROM employees as e
JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
	AND (de.from_date BETWEEN '1985-01-01' AND '1988-12-31')
ORDER BY e.emp_no;

SELECT DISTINCT ON (emp_no) e.emp_no,
							d.dept_name,
							e.first_name, 
							e.last_name, 
							e.birth_date, 
							de.from_date, 
							de.to_date, 
							t.title
INTO employees_leaving_by_dept
FROM employees as e
JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
LEFT JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
	AND (de.from_date BETWEEN '1985-01-01' AND '1988-12-31')
ORDER BY e.emp_no;

--group employees leavingby dept.
SELECT COUNT(first_name) "Count", dept_name
FROM employees_leaving_by_dept
GROUP BY dept_name
ORDER BY "Count" desc;


