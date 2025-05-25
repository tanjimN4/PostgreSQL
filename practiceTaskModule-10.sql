-- Create departments table
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create students table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    score DECIMAL(5, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments (id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Create course_enrollments table
CREATE TABLE course_enrollments (
    id SERIAL PRIMARY KEY,
    student_id INT,
    course_title VARCHAR(255) NOT NULL,
    enrolled_on DATE,
    FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS course_enrollments CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS departments CASCADE;


INSERT INTO
    departments (name)
VALUES ('CSE'),
    ('EEE'),
    ('BBA'),
    ('ME'),
    ('CE');

INSERT INTO
    students (
        name,
        age,
        score,
        department_id
    )
VALUES ('Alice Johnson', 20, 85.50, 1),
    ('Bob Smith', 21, 78.25, 2),
    ('Charlie Lee', 22, 92.00, 1),
    ('Diana Patel', 23, 67.75, 3),
    ('Ethan Clark', 20, 88.40, 2),
    ('Fatima Khan', 19, 73.10, 4),
    ('George Wilson', 22, 60.00, 5),
    ('Hannah Kim', 21, 95.00, 1),
    ('Ivan Martinez', 20, 82.30, 3),
    ('Jasmine Liu', 24, 89.75, 2),
    ('Khaled Omar', 22, 70.50, 5),
    ('Laura Chen', 21, 96.20, 1),
    ('Michael Brown', 23, 59.80, 3),
    ('Nina Das', 22, 84.60, 4),
    ('Oscar White', 20, 91.25, 1),
    ('Priya Verma', 21, 76.90, 2),
    ('Quincy Jones', 23, 69.45, 3),
    ('Rita Singh', 19, 87.00, 4),
    ('Steve Park', 22, 90.10, 5),
    ('Tina Roy', 20, 93.50, 1);

INSERT INTO
    course_enrollments (
        student_id,
        course_title,
        enrolled_on
    )
VALUES (
        1,
        'Data Structures',
        '2024-01-10'
    ),
    (2, 'Circuits I', '2024-02-15'),
    (3, 'Algorithms', '2024-01-12'),
    (
        4,
        'Marketing Basics',
        '2024-03-01'
    ),
    (
        5,
        'Electronics',
        '2024-01-25'
    ),
    (
        6,
        'Thermodynamics',
        '2024-02-20'
    ),
    (
        7,
        'Structural Analysis',
        '2024-03-10'
    ),
    (
        8,
        'Machine Learning',
        '2024-04-05'
    ),
    (
        9,
        'Financial Management',
        '2024-01-18'
    ),
    (
        10,
        'Digital Logic',
        '2024-02-22'
    ),
    (11, 'Surveying', '2024-03-15'),
    (
        12,
        'Operating Systems',
        '2024-01-30'
    ),
    (
        13,
        'Organizational Behavior',
        '2024-03-28'
    ),
    (
        14,
        'Heat Transfer',
        '2024-04-01'
    ),
    (
        15,
        'Artificial Intelligence',
        '2024-01-14'
    ),
    (
        16,
        'Signal Processing',
        '2024-02-18'
    ),
    (17, 'Economics', '2024-03-05'),
    (
        18,
        'Material Science',
        '2024-02-07'
    ),
    (
        19,
        'Engineering Graphics',
        '2024-01-20'
    ),
    (
        20,
        'Computer Networks',
        '2024-04-10'
    );

-- Retrieve all students who scored higher than the average score.

SELECT avg(score) FROM students

SELECT *
FROM students
WHERE
    score > (
        SELECT avg(score)
        FROM students
    )

-- Find students whose age is greater than the average age of all students.

SELECT avg(age) FROM students

SELECT *
FROM students
WHERE
    age > (
        SELECT avg(age)
        FROM students
    )

-- Get names of students who are enrolled in any course (use IN with subquery).
SELECT student_id FROM course_enrollments

SELECT *
FROM students
WHERE
    id in (
        SELECT student_id
        FROM course_enrollments
    )

-- Retrieve departments with at least one student scoring above 90 (use EXISTS)

SELECT *
FROM departments d
WHERE
    EXISTS (
        SELECT 1
        FROM students s
        WHERE
            s.department_id = d.id
            AND s.score > 90
    )

-- Create a view to show each student’s name, department, and score.

CREATE View st_dep_sc AS
SELECT students.name, departments.name as department, students.score
FROM students
    JOIN departments ON students.department_id = departments.id

SELECT * FROM st_dep_sc

-- Create a view that lists all students enrolled in any course with the enrollment date.
CREATE View st_enrol_course_date AS
SELECT course_enrollments.id, students.name, course_enrollments.enrolled_on
FROM
    students
    JOIN course_enrollments ON students.id = course_enrollments.student_id;

SELECT * FROM st_enrol_course_date;

-- Create a function that takes a student's score and returns a grade (e.g., A, B, C, F).
CREATE Function get_grade(score NUMERIC)
RETURNS CHARACTER
LANGUAGE plpgsql
as
$$
BEGIN
IF score >= 90 THEN
        RETURN 'A';
    ELSIF score >= 80 THEN
        RETURN 'B';
    ELSIF score >= 70 THEN
        RETURN 'C';
    ELSE
        RETURN 'F';
    END IF;
END
$$;

SELECT get_grade (92);
-- Returns 'A'
SELECT get_grade (77);
-- Returns 'C'

-- Create a function that returns the full name and department of a student by ID.

CREATE OR REPLACE FUNCTION st_name_dep (stu_id INT)
    RETURNS TABLE(st_name TEXT,department TEXT)
    LANGUAGE plpgsql
    AS
    $$
    BEGIN
    RETURN query
    SELECT s.name::TEXT as st_name,d.name::TEXT as department FROM students as s
    JOIN departments as d on s.department_id =d.id
    WHERE s.id=stu_id;
    END;
    $$;



SELECT * FROM st_name_dep(4);


-- Write a stored procedure to update a student's department.
CREATE Procedure up_st_dep(
    stu_id INT,
    new_dept_id INT
)
LANGUAGE plpgsql
AS
$$
BEGIN
UPDATE students
SET department_id =new_dept_id
WHERE id =stu_id;
END;
$$;

call up_st_dep(1,5)


-- Write a procedure to delete students who haven't enrolled in any course.

CREATE OR REPLACE PROCEDURE delete_unenrolled_st()
LANGUAGE plpgsql
AS
$$
BEGIN
    DELETE FROM students
    WHERE id NOT IN (
        SELECT student_id FROM course_enrollments
    );
END;
$$;

CALL delete_unenrolled_st();

-- Add an index to the score column in the students table.

EXPLAIN ANALYSE
SELECT * FROM students
WHERE age = 19

CREATE INDEX inx_stu_score
ON students(score)




-- Add a composite index on student_id and enrolled_on in the course_enrollments table.
CREATE INDEX idx_student_enroll_date
ON course_enrollments (student_id, enrolled_on);



-- Compare query performance with and without indexes using EXPLAIN
SELECT *
FROM course_enrollments
WHERE student_id = 3 AND enrolled_on = '2024-01-12';

EXPLAIN SELECT *
FROM course_enrollments
WHERE student_id = 3 AND enrolled_on = '2024-01-12';





SELECT * FROM departments

SELECT * FROM students

SELECT * FROM course_enrollments
