-- Grouping and Filtering Data with GROUP BY and HAVING

select country ,count(*),avg(age) FROM students
 GROUP BY country HAVING avg(age) >21

 -- Filter Groups Using HAVING to Show Only Countries with Average Age Above 20.60

 SELECT country, avg(age) FROM students
 GROUP BY country HAVING avg(age) > 20.60

 -- Count Students Born in Each Year
 SELECT extract(YEAR FROM dob) as birth_year, count(*) FROM students
 GROUP BY birth_year 