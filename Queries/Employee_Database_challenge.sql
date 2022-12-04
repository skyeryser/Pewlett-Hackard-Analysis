-- All employees born between 1952 and 1955:
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- All unique employees of retirement age:
SELECT DISTINCT ON (emp_no)
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT COUNT(emp_no) FROM unique_titles;

-- Total count of employees of retirement age by title:
SELECT COUNT(title) AS count,
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;

-- Mentorship eligibility:
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
JOIN dept_emp AS d
ON e.emp_no = d.emp_no
JOIN titles AS t
ON t.emp_no = e.emp_no
WHERE d.to_date = '9999-01-01' 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT COUNT(emp_no) FROM mentorship_eligibility;