CREATE TYPE status_enum AS ENUM ('pass', 'fail');

CREATE Table students (
    id INT PRIMARY KEY,
    roll INT UNIQUE,
    name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    score INT,
    status status_enum,
    last_login DATE
)

INSERT INTO students (id, roll, name, age, department, score, status, last_login) VALUES
(1, 1001, 'Alice Johnson', 20, 'Computer Science', NULL, 'pass', '2024-09-01'),
(2, 1002, 'Bob Smith', 22, 'Mathematics', 67, 'pass', '2024-08-25'),
(3, 1003, 'Charlie Davis', 21, 'Physics', 49, 'fail', '2024-09-05'),
(4, 1004, 'Diana Evans', 19, 'Chemistry', 92, 'pass', '2024-09-10'),
(5, 1005, 'Ethan Brown', 23, 'Biology', 55, 'pass', '2024-08-29'),
(6, 1006, 'Fiona Harris', 20, 'Computer Science', 78, 'pass', '2024-08-30'),
(7, 1007, 'George Wright', 22, 'Mathematics', 60, 'pass', '2024-08-28'),
(8, 1008, 'Hannah Scott', 21, 'Physics', 44, 'fail', '2024-08-15'),
(9, 1009, 'Ian Clark', 20, 'Biology', 36, 'fail', '2024-07-20'),
(10, 1010, 'Julia Adams', 18, 'Chemistry', 80, 'pass', '2024-09-12'),
(11, 1011, 'Kevin Martin', 21, 'Computer Science', 90, 'pass', '2024-08-21'),
(12, 1012, 'Laura Lewis', 22, 'Mathematics', 53, 'pass', '2024-07-30'),
(13, 1013, 'Michael Walker', 23, 'Physics', 47, 'fail', '2024-09-06'),
(14, 1014, 'Nina Hall', 20, 'Biology', 62, 'pass', '2024-08-19'),
(15, 1015, 'Oscar Allen', 19, 'Chemistry', 59, 'pass', '2024-08-10'),
(16, 1016, 'Paula Young', 20, 'Computer Science', 42, 'fail', '2024-08-22'),
(17, 1017, 'Quinn Hernandez', 21, 'Mathematics', 88, 'pass', '2024-08-18'),
(18, 1018, 'Rachel King', 22, 'Physics', 91, 'pass', '2024-09-08'),
(19, 1019, 'Samuel Green', 20, 'Biology', 39, 'fail', '2024-08-05'),
(20, 1020, 'Tina Baker', 18, 'Chemistry', 73, 'pass', '2024-08-27'),
(21, 1021, 'Uma Perez', 19, 'Computer Science', 87, 'pass', '2024-08-29'),
(22, 1022, 'Victor Murphy', 22, 'Mathematics', 41, 'fail', '2024-08-13'),
(23, 1023, 'Wendy Rivera', 20, 'Physics', 68, 'pass', '2024-08-24'),
(24, 1024, 'Xander Reed', 21, 'Biology', 52, 'pass', '2024-08-31'),
(25, 1025, 'Yara Wood', 19, 'Chemistry', 34, 'fail', '2025-05-11'),
(26, 1026, 'Zane Russell', 23, 'Computer Science', 96, 'pass', '2024-08-20'),
(27, 1027, 'Amy Stone', 20, 'Mathematics', 49, 'fail', '2024-08-26'),
(28, 1028, 'Ben Foster', 22, 'Physics', 63, 'pass', '2022-09-03'),
(29, 1029, 'Cathy Bell', 21, 'Biology', 75, 'pass', '2023-08-14'),
(30, 1030, 'Derek Ward', 20, 'Chemistry', 58, 'pass', '2024-08-17');

SELECT * FROM students

DROP TABLE students

ALTER Table students
ADD COLUMN email VARCHAR(100);
ALTER Table students
RENAME email to student_email

ALTER TABLE students
ADD CONSTRAINT student_email UNIQUE (student_email);

-- Add a PRIMARY KEY to a new table named courses.
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_description VARCHAR(200)
    );



INSERT INTO courses (course_id, course_name, course_description) VALUES
(1, 'Introduction to Programming', 'Learn the basics of programming using Python.'),
(2, 'Database Systems', 'Covers relational databases, SQL, and database design principles.'),
(3, 'Data Structures and Algorithms', 'Study of efficient data organization and algorithms for problem solving.'),
(4, 'Web Development', 'Build modern web applications using HTML, CSS, JavaScript, and frameworks.'),
(5, 'Computer Networks', 'Understand how data moves across networks, including protocols and topologies.');

SELECT * from courses

ALTER TABLE courses
DROP COLUMN course_name;


SELECT score FROM students
WHERE score >= 80 and score IS NOT NULL

SELECT * FROM students
WHERE not department = 'Biology'

SELECT NAME FROM students
WHERE name ILIKE 'A%'

SELECT * FROM students
WHERE age >18 AND age <22

SELECT * FROM students
WHERE roll in ('1019','1018')


SELECT count(id) FROM students

SELECT department ,avg(score) FROM students
WHERE department = 'Physics'
GROUP BY department 

SELECT max(age),min(age) FROM students

UPDATE students
SET status = 'fail'
WHERE score <= 60

DELETE FROM students 
WHERE extract(YEAR FROM last_login) < extract(YEAR FROM CURRENT_DATE)

SELECT * FROM students


SELECT * FROM students
LIMIT 5 OFFSET 5