## **PostgreSQL Quick Reference**

## [Table of Contents](#table-of-contents)

1. [Connecting to PostgreSQL](#1-connecting-to-postgresql)
2. [Creating Database](#2-creating-database)
3. [Switching Databases and Exiting](#3-switching-databases-and-exiting)
4. [Listing Information](#4-listing-information)
5. [Managing Users / Roles](#5-managing-users--roles)
6. [Login as New User](#6-login-as-new-user)
7. [Table Operations](#7-table-operations)
8. [Granting and Revoking Permissions](#8-granting-and-revoking-permissions)
9. [Renaming and Deleting Databases](#9-renaming-and-deleting-databases)
10. [Renaming and Deleting Tables](#10-renaming-and-deleting-tables)
11. [Table with Constraints](#11-table-with-constraints)
12. [Clearing Terminal](#12-clearing-terminal)
13. [PostgreSQL Data Types](#13-postgresql-data-types)
14. [Modifying Columns in PostgreSQL](#14-modifying-columns-in-postgresql)
15. [Creating a Table](#15-creating-a-table)
16. [Selecting Data](#16-selecting-data)
17. [Data Filtering (`WHERE` Clause)](#17-data-filtering-where-clause)
18. [Scalar Functions](#18-scalar-functions)
19. [Aggregate Functions](#19-aggregate-functions)
20. [`NULL` Filtering](#20-null-filtering)
21. [Handling `NULL` with COALESCE](#21-handling-null-with-coalesce)
22. [`IN` Operator](#22-in-operator)
23. [`BETWEEN` Operator](#23-between-operator)
24. [`LIKE` Operator](#24-like-operator)
25. [Updating and Deleting Data](#25-updating-and-deleting-data)
26. [Pagination (`LIMIT` and `OFFSET`)](#26-pagination-limit-and-offset)
27. [Date, Time, and Boolean Operations](#27-date-time-and-boolean-operations)
28. [Grouping and Filtering Data with `GROUP BY` and `HAVING`](#28-grouping-and-filtering-data-with-group-by-and-having)
29. [Foreign Key Constraints and `ON DELETE` Actions](#29-foreign-key-constraints-and-on-delete-actions)
30. [Joins in PostgreSQL](#30-joins-in-postgresql)
31. [Additional Join Examples](#31-additional-join-examples)

### **1. Connecting to PostgreSQL**

- **Basic connection:**
  ```bash
  psql
  ```
- **Connect with a specific user (e.g., the user is postgres here):**
  ```bash
  psql -U postgres
  ```
- **Connect to a specific database:**
  ```bash
  psql -U postgres -d test_db; #uses the test_db with the superuser Postgres
  psql -U user1 -d postgres;
  ```
- **View connection info (gives the user details and port name):**
  ```sql
  \conninfo
  ```

---

### **2. Creating Database**

- **Create a database:**
  ```sql
  CREATE DATABASE test_db;
  --or,
  create database test_db1; --not case sensitive
  ```

---

### **3. Switching Databases and Exiting**

- **Connect to another DB while in `psql`:**

  ```sql
  \c test_db
  ```

- **Quit `psql`:**
  ```sql
  \q
  ```

---

### **4. Listing Information**

- **List all databases:**
  ```sql
  \l
  ```
- **List all users/roles:**
  ```sql
  \du
  ```
- **List all schemas (inside a DB):**
  ```sql
  \dn
  ```

---

### **5. Managing Users / Roles**

- **Create a user:**
  ```sql
  CREATE USER user2;
  CREATE USER user1 WITH LOGIN ENCRYPTED PASSWORD '12345';
  ```
- **Create a role:**
  ```sql
  CREATE ROLE role1 WITH LOGIN ENCRYPTED PASSWORD '12345';
  ```

[🔼 Back to Table of Contents](#table-of-contents)

### **6. Login as New User**

- **Access database with a user:**
  ```bash
  psql -U user1 -d postgres;
  ```

> Note: User must have permission on the database.

---

### **7. Table Operations**

- **Create a table example:**
  ```sql
  CREATE TABLE test_table (
    name VARCHAR(50) --here, name is the column name, varchar is a datatype and test_table is the name of the table
  );
  ```
- **Insert data:**
  ```sql
  INSERT INTO test_table (name)
  VALUES ('ayesha');
  ```
- **Select data (to view/read everything in a table):**
  ```sql
  SELECT * FROM test_table;
  ```

---

### **8. Granting and Revoking Permissions**

- **Switch user and connect to a database:**
  ```bash
  psql -U user4 -d postgres;
  ```
  _(switching from one user to another)_
- **Grant all privileges on a table to a user:**
  ```sql
  GRANT ALL PRIVILEGES ON TABLE test_table TO user4;
  ```
  _(postgres is a superuser, but other users are not; to allow a user to access a table, the superuser must grant permissions.)_
- **Grant select (read-only) permission on a table:**
  ```sql
  GRANT SELECT ON TABLE test_table TO user3;
  ```
  _(gives permission to view the table but not insert or delete)_
- **Revoke select permission on a table:**
  ```sql
  REVOKE SELECT ON TABLE test_table FROM user3
  ```
  _(revokes viewing permission)_
- **Grant all privileges on all tables in schema `public` to a user:**
  ```sql
  GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO user3;
  ```
  _(gives permission on all tables)_
- **Grant select on all tables in schema `public` to a role:**
  ```sql
  GRANT SELECT ON ALL TABLES IN SCHEMA public TO role1;
  ```
  _(to allow role to view/read all databases)_
- **Grant a role to a user:**
  ```sql
  GRANT role1 TO user3;
  ```
  _(grants role access to user)_

---

### **9. Renaming and Deleting Databases**

- **Rename a database:**
  ```sql
  ALTER DATABASE test_db RENAME TO another_db;
  ```
- **Delete (drop) a database:**
  ```sql
  DROP DATABASE another_db;
  ```
  [🔼 Back to Table of Contents](#table-of-contents)

---

### **10. Renaming and Deleting Tables**

- **Rename a table:**
  ```sql
  ALTER TABLE person RENAME TO student;
  ```
- **Delete (drop) a table:**
  ```sql
  DROP TABLE your_table;
  ```

---

### **11. Table with constraints**

- **Table creation template with constraints:**
  ```sql
  CREATE TABLE table_name (
      column1 datatype constraint,
      column2 datatype constraint,
      column3 datatype constraint,
      ...
  );
  ```
- **Creating Tables with Constraints example**

  ```sql

  CREATE TABLE person (
      person_id SERIAL PRIMARY KEY,  -- SERIAL auto-increments, PRIMARY KEY enforces uniqueness and NOT NULL
      first_name VARCHAR(50) NOT NULL, -- Limits text to 50 characters, NOT NULL ensures the value must be provided
      last_name VARCHAR(50) NOT NULL,  -- Same as above, for the last name
      is_active BOOLEAN DEFAULT true, -- BOOLEAN type, DEFAULT sets initial value to true if not provided
      age INTEGER CHECK (age >= 0),  -- INTEGER type, CHECK ensures age must be zero or greater
      email VARCHAR(255) UNIQUE   -- UNIQUE ensures no duplicate emails
  );

  ```

- **Foreign Key Constraint**
  - Values in the foreign key column must exist in the referenced primary key column.
  - Example Tables:

| **Product** |                | **Order**    |             | **Customer**    |          |
| ----------- | -------------- | ------------ | ----------- | --------------- | -------- |
| **prod_id** | **prod_title** | **order_id** | **prod_id** | **customer_id** | **name** |
| 1           | shoe           | 1            | 1           | 1               | Alice    |
| 2           | t-shirt        | 2            | 2           | 2               | Bob      |

```sql
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    prod_id SERIAL PRIMARY KEY,
    prod_title VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    prod_id INTEGER REFERENCES products(prod_id)      -- foreign key to products
);
--customer_id in orders table is a foreign key that references customer_id in the customers table.

--This means you cannot insert a customer_id in orders unless it exists in the customers table.
```

- **Multiple Column Primary Key Example**

  ```sql
  CREATE TABLE person2 (
      id SERIAL,
      user_name VARCHAR(20),
      age INTEGER CHECK (age >= 18),
      PRIMARY KEY (id, user_name),
      UNIQUE (user_name, age)
  );

  ```

- **Single-Row Insert template**

  ```sql
  INSERT INTO your_table (column1, column2, column3)
  VALUES (value1, value2, value3);

  ```

- **Single-Row Insert example**
  ```sql
  INSERT INTO employees (first_name, last_name, hire_date)
  VALUES ('John', 'Doe', '2022-01-22');
  ```
- **Multi-Row Insert template**

  ```sql
  INSERT INTO your_table (column1, column2, column3)
  VALUES
      (value1_1, value2_1, value3_1),
      (value1_2, value2_2, value3_2),
      ...;

  ```

- **Multi-Row Insert Example**

  ```sql
  INSERT INTO employees (first_name, last_name, hire_date)
  VALUES
      ('Jane', 'Smith', '2022-02-20'),
      ('Bob', 'Johnson', '2022-03-25');

  ```

- **If we know the columns (not recommended)**
  ```sql
  -- Assuming table person has columns (id, name, age)
  INSERT INTO persons VALUES (1, 'John Doe', 23);
  ```

---

### **12. Clearing Terminal**

- **Clear terminal from `psql`:**

  ```sql
  \! clear   -- Linux/macOS
  \! cls     -- Windows

  ```

---

### **13. PostgreSQL Data Types**

1. **Integer Types**

| Type       | Range                                                   | Storage | Notes                                              |
| ---------- | ------------------------------------------------------- | ------- | -------------------------------------------------- |
| `INT`      | -2,147,483,648 to 2,147,483,647                         | 4 bytes | Commonly used standard integer                     |
| `BIGINT`   | -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 | 8 bytes | For very large integers                            |
| `SMALLINT` | -32,768 to 32,767                                       | 2 bytes | For small integer range                            |
| `SERIAL`   | Like `INT`                                              | 4 bytes | Auto-incrementing integer, useful for primary keys |

---

2. **Floating-Point Types**

| Type      | Storage  | Precision          | Notes                                       |
| --------- | -------- | ------------------ | ------------------------------------------- |
| `FLOAT4`  | 4 bytes  | ~6 decimal digits  | Single precision                            |
| `FLOAT8`  | 8 bytes  | ~15 decimal digits | Double precision                            |
| `NUMERIC` | Variable | User-defined       | Exact precision, for financial calculations |

---

3. **Character Types**

| Type         | Storage              | Notes                                                                                |
| ------------ | -------------------- | ------------------------------------------------------------------------------------ |
| `CHAR(n)`    | Fixed length, padded | Fixed-length character string                                                        |
| `VARCHAR(n)` | Variable length      | Variable-length character string up to `n` (recommended over `CHAR(n)` saves space). |
| `TEXT`       | Variable length      | Unlimited length text, similar to `VARCHAR` but no length limit                      |

---

4. **UUID**

- **Definition:** Universally Unique Identifier type
- **Storage:** 128-bit (16 bytes), represented as 32 hex digits with hyphens
- **Example:** `3c0ab34f-51f4-4d7b-84ee-b197af61dcb3`

---

5. **Date and Time Types**

| Type          | Storage  | Notes                         |
| ------------- | -------- | ----------------------------- |
| `DATE`        | 4 bytes  | Stores calendar date          |
| `TIME`        | 8 bytes  | Stores time of day (no date)  |
| `TIMESTAMP`   | 8 bytes  | Stores both date and time     |
| `TIMESTAMPTZ` | 8 bytes  | Timestamp with time zone      |
| `INTERVAL`    | Variable | Represents time span/duration |

---

6. **Boolean**

| Type      | Storage | Notes                       |
| --------- | ------- | --------------------------- |
| `BOOLEAN` | 1 byte  | Stores TRUE or FALSE values |

[🔼 Back to Table of Contents](#table-of-contents)

### **14. Modifying Columns in PostgreSQL**

- **Select Data from Table**

```sql
SELECT * FROM person3;
```

- **Add a Column**

```sql
ALTER TABLE person3
ADD COLUMN email VARCHAR(25) DEFAULT 'default@email.com' NOT NULL;
```

_Adds `email` column with a default value and `NOT NULL` constraint_

- **Insert Data into Table**

```sql
INSERT INTO person3 VALUES (5, 'test2', 45, 'test@gmail.com');
```

_Inserts a new row into `person3`._

- **Delete a Column**

```sql
ALTER TABLE person3 DROP COLUMN email;
```

_Removes the `email` column from `person3`._

- **Rename a Column**

```sql
ALTER TABLE person3 RENAME COLUMN age TO user_age;
```

_Renames `age` column to `user_age`._

- **Change Data Type of a Column**

```sql
ALTER TABLE person3 ALTER COLUMN user_name TYPE VARCHAR(50);
```

_Alters the `user_name` column to have a maximum length of 50 characters._

- **Add Constraint to Existing Column**

```sql
ALTER TABLE person3 ALTER COLUMN user_age SET NOT NULL;
```

_Adds `NOT NULL` constraint to `user_age` column._

> Note: Constraints like `DEFAULT`, `UNIQUE`, `PRIMARY KEY`, and `FOREIGN KEY` cannot be added with like this.

- **Delete a Constraint**

```sql
ALTER TABLE person3 ALTER COLUMN user_age DROP NOT NULL;
```

_Removes the `NOT NULL` constraint from `user_age`._

- **Add a New Column**

```sql
ALTER TABLE person3 ADD COLUMN user_address VARCHAR(255);
```

_Adds `user_address` column with a maximum length of 255 characters._

- **Insert Data into New Column**

```sql
INSERT INTO person3 VALUES (11, 'test3', 20, 'sylhet');
```

_Inserts new data into the table._

- **Add Unique Constraint**

```sql
ALTER TABLE person3
ADD CONSTRAINT unique_person3_user_address UNIQUE (user_address);
```

_Adds a `UNIQUE` constraint to the `user_address` column._

- **Add Foreign Key Constraint**

```sql
ALTER table students
add constraint fk_department_id
FOREIGN key (department_id)
REFERENCES departments(id)
```

> _`fk_students_department` is the name of the constraint (you can choose any name). This enforces that any department_id in students table must exist in departments.id, or be NULL._

- **Delete a Unique Constraint**

```sql
ALTER TABLE person3 ALTER COLUMN user_name DROP UNIQUE; --will give syntax error
```

- **Error**: You can't directly drop a `UNIQUE` constraint this way; it needs to be done via `DROP CONSTRAINT`.

```sql
ALTER TABLE person3 DROP CONSTRAINT unique_person3_user_address;
```

_Removes the `unique_person3_user_address` constraint._

### ** PostgreSQL Operations - Queries and Commands - Basic Table Operations**

---

### **15. Creating a Table**

- **Creating a Table named students**

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    age INT,
    grade CHAR(2),
    course VARCHAR(50),
    email VARCHAR(100),
    dob DATE,
    blood_group VARCHAR(5),
    country VARCHAR(50)
);
```

---

### **16. Selecting Data**

- **Select All Rows**

```sql
SELECT * FROM students;
```

- **Select Specific Column**

```sql
SELECT email FROM students;
```

- **Select or View Multiple Columns**

```sql
SELECT email, age FROM students;
```

- **Using Aliases**

```sql
SELECT email AS studentEmail FROM students;
SELECT email AS "student email" FROM students;  -- Use double quotes for column names
```

- **Order By**

```sql
SELECT * FROM students ORDER BY firstName ASC;  -- Ascending (A-Z)
SELECT * FROM students ORDER BY firstName DESC;  -- Descending (Z-A)
SELECT country FROM students ORDER BY country ASC;  -- List countries A-Z
SELECT * FROM students ORDER BY student_id;  -- sorted by ID
```

- **Distinct Values**

```sql
SELECT DISTINCT country FROM students;  -- Unique countries
```

---

### **17. Data Filtering (`WHERE` Clause)**

- **Filtering by Country**

```sql
SELECT * FROM students WHERE country = 'USA'; --viewing students only from the USA (conditional filtering)

```

- **Multiple Conditions (AND / OR)**

```sql
--select students with A grade in chemistry
SELECT * FROM students WHERE grade = 'A' AND course = 'Chemistry';

--select students from the USA or Canada
SELECT * FROM students WHERE country = 'USA' OR country = 'Canada';

--select students from the USA or Canada and the age is 20
SELECT * FROM students WHERE (country = 'USA' OR country = 'Canada') AND age = 20;
```

- **Filtering by Range**

```sql
SELECT * FROM students WHERE age > 20;  -- Age greater than 20
SELECT * FROM students WHERE age BETWEEN 19 AND 22;  -- Between 19 and 22

--select students older than 20 years old with course history;
SELECT * FROM students WHERE age > 20 AND course = 'History';
```

- **Not Equal**

```sql
SELECT * FROM students WHERE age <> 20;  -- Not 20 years old

--similar action but different syntax:
SELECT * FROM students WHERE age != 20;
SELECT * FROM students WHERE NOT age = 20;
```

- **String Matching (LIKE / ILIKE)**

```sql
SELECT * FROM students WHERE firstName LIKE '%am';  -- Ends with 'am'
SELECT * FROM students WHERE firstName LIKE 'A%';  -- Starts with 'A'
SELECT * FROM students WHERE firstName ILIKE 'a%';  -- Case-insensitive search
SELECT * FROM students WHERE firstName LIKE '__a';  -- Third letter is 'a'
```

---

### **18. Scalar Functions**

> **Scalar functions** are functions that operate on single values (scalar values) and return a single value as the result.

- **UPPER()**

  Converts all characters in a string to uppercase.

  ```sql
  SELECT upper(firstName) FROM students;

  --make every letter of firstName uppercase and view the whole table
  SELECT upper(firstName) AS firstNameInUppercase, * FROM students; --alias
  ```

- **LOWER()**

  Converts all characters in a string to lowercase.

  ```sql
  SELECT lower(firstName) FROM students;

  ```

- **CONCAT()**

  Concatenates two or more strings together.

  ```sql
  SELECT concat(firstName, ' ', lastName) FROM students;

  ```

- **LENGTH()**

  Returns the number of characters in a string.

  ```sql
  SELECT length(firstName) FROM students;

  ```

---

### **19. Aggregate Functions**

> **Aggregate functions** in PostgreSQL are used to perform calculations on a set of rows and return a single result.

- **Average Age**

  AVG() calculates the average of a set of values.

```sql
SELECT avg(age) FROM students;

```

- **Max Age**

  MAX() returns the max value in a set.

```sql
SELECT max(age) FROM students;

```

- MIN() returns the minimum value in a set.
- SUM() calculates the sum of values in a set.
- **Count Rows**

```sql
SELECT count(*) FROM students;

```

- **Find Longest Name**

```sql
SELECT max(length(firstName)) FROM students;

```

---

### **20. `NULL` Filtering**

```sql
SELECT * FROM students WHERE email IS NULL;  -- Rows with no email
SELECT * FROM students WHERE email = 'rachel.garcia@example.com';  -- Specific email

```

---

### **21. Handling `NULL` with COALESCE**

- **Default Placeholder for NULL (Using COALESCE for Default Values)**

```sql
SELECT COALESCE(email, 'Email Not Provided'), age, blood_group FROM students;

```

---

### **22. `IN` Operator**

The `IN` operator is used to check if a value matches any value in a list of values. Can be used to shorten multiple OR operators.

- **e.g. View students only from the USA, UK, and Canada:**

  ```sql
  --with OR operator
  SELECT *
  FROM students
  WHERE
      country = 'USA'
      OR country = 'Canada'
      OR country = 'UK';

  --with IN operator (shorter)
  SELECT * FROM students WHERE country IN ('USA', 'UK', 'Canada');

  ```

- **View students not from the USA, UK, and Canada:**

  ```sql
  SELECT * FROM students WHERE country NOT IN ('USA', 'UK', 'Canada');

  ```

### **23. `BETWEEN` Operator**

The `BETWEEN` operator is used to filter the results within a range (inclusive).

- **View students with ages between 19 and 22:**

  ```sql
  SELECT * FROM students WHERE age BETWEEN 19 AND 22;

  ```

- **View students with `dob` between '2001-01-01' and '2002-12-12':**

  ```sql
  SELECT * FROM students WHERE dob BETWEEN '2001-01-01' AND '2002-12-12';

  ```

---

### **24. `LIKE` Operator**

The `LIKE` operator is used to search for a specified pattern in a column.

- **Find names that contain 'am' at the last:**

  ```sql
  SELECT * FROM students WHERE firstName LIKE '%am';

  ```

  - `%` is a wildcard that matches zero or more characters.

- **Names starting with 'A':**

  ```sql
  SELECT * FROM students WHERE firstName LIKE 'A%';

  ```

  - `%` matches any number of characters after 'A'.

- **Case-sensitive matching with `LIKE`:**

  ```sql
  SELECT * FROM students WHERE firstname LIKE 'a%'; --will not give the names start with 'A'

  ```

- **Case-insensitive matching with `ILIKE`:**

  ```sql
  SELECT * FROM students WHERE firstname ILIKE 'a%'; --gives names starting with 'A'.

  ```

- **Third letter is 'a' (underscore `_` matches a single character):**

  ```sql
  SELECT * FROM students WHERE firstname LIKE '__a'; --e.g. Eva, Mia

  ```

- **Names with 'o' as the third letter and two characters in between:**

  ```sql
  SELECT * FROM students WHERE lastname LIKE '__o__'; --e.g. Brown, Moore

  ```

---

### **25. Updating and Deleting Data**

- **Update Data**

```sql
UPDATE students
SET email = 'default2@test.com', age = 30
WHERE student_id = 5;

--another example
UPDATE students SET email = NULL WHERE student_id = 4;

```

- **Delete Data**

```sql

DELETE FROM students WHERE grade = 'B';  -- Delete all B grade students
DELETE FROM students WHERE grade = 'C+' AND country = 'Ireland';  -- Specific condition

```

- **Delete All Rows**

```sql
DELETE FROM students;  -- Deletes all rows in the table

```

---

### **26. Pagination (`LIMIT` and `OFFSET`)**

- **Limit Results**

```sql
SELECT * FROM students LIMIT 5;  -- Shows first 5 rows
SELECT * FROM students LIMIT 5 OFFSET 2;  -- Skips the first 2, shows next 5 rows

```

- **Pagination Example**

```sql
SELECT * FROM students LIMIT 5 OFFSET 5 * 0;  -- Rows 1-6
SELECT * FROM students LIMIT 5 OFFSET 5 * 1;  -- Rows 7-11
SELECT * FROM students LIMIT 5 OFFSET 5 * 2;  -- Rows 12-17

```

[🔼 Back to Table of Contents](#table-of-contents)

### **27. Date, Time, and Boolean Operations**

- **Show current timezone:**

```sql
SHOW timezone;
```

- **Current timestamp (includes date, time, and timezone):**

```sql
SELECT now();
```

- **Create a table with timestamp fields:**

```sql
CREATE TABLE timeZ (
    ts TIMESTAMP WITHOUT TIME ZONE,
    tsz TIMESTAMP WITH TIME ZONE
);
```

- **Insert sample data:**

```sql
INSERT INTO timeZ
VALUES (
    '2024-12-05 10:45:07',
    '2024-12-05 10:45:07'
);
```

- **View table contents:**

```sql
SELECT * FROM timeZ; --2024-12-05 10:45:07	  2024-12-05 10:45:07-05
```

- **Show today’s date:**

```sql
SELECT CURRENT_DATE;
SELECT now()::date;  -- Casts timestamp to date
```

- **Show current time:**

```sql
SELECT now()::time;  -- Casts timestamp to time
```

- **Format timestamp as string:**

```sql
SELECT to_char(now(), 'mm-dd-yyyy');
SELECT to_char(now(), 'Mon');     -- e.g., May
SELECT to_char(now(), 'Month');   -- e.g., May
SELECT to_char(now(), 'MONTH');   -- e.g., MAY
SELECT to_char(now(), 'DDD');     -- Day of the year
```

- **Date arithmetic (subtracting intervals):**

```sql
SELECT CURRENT_DATE - INTERVAL '1 year'; --the day before one year from today
SELECT CURRENT_DATE - INTERVAL '1 year 2 month';-- the day before one year and 2 months from today
```

- **Calculate age:**

```sql
SELECT age(CURRENT_DATE, '1995-11-1');  -- Result in years, months, days, e,g., "years":29,"months":6,"days":19

--calculating age of each student
SELECT *, age(CURRENT_DATE, dob) FROM students;
```

- **Extract parts from a date:**

```sql
SELECT extract(YEAR FROM '2023-08-12'::date); --2023
SELECT extract(MONTH FROM '2023-08-12'::date); ----8
SELECT extract(DAY FROM '2023-08-12'::date); ----12
```

- **Boolean casting examples:**

```sql
SELECT 1::Boolean;        -- true
SELECT 'n'::Boolean;      -- false
SELECT 'y'::Boolean;      -- true
SELECT 'f'::Boolean;      -- false
SELECT 't'::Boolean;      -- true
SELECT 'no'::Boolean;     -- false
SELECT 'yes'::Boolean;    -- true
```

---

### **28. Grouping and Filtering Data with `GROUP BY` and `HAVING`**

- **Group by country:**

```sql
SELECT country FROM students GROUP BY country;
-- Lists distinct countries
```

- **Count students in each country:**

```sql
SELECT country, count(*) FROM students GROUP BY country;
```

- **Average age per country:**

```sql
SELECT country, avg(age) FROM students GROUP BY country;
```

- **Filter groups using `HAVING`:**

```sql
SELECT country, avg(age)
FROM students
GROUP BY country
HAVING avg(age) > 20;
-- Filters country groups where average age > 20
```

> Note: `WHERE` filters individual rows; `HAVING` filters grouped results.

- **Count students born in each year:**

```sql
SELECT extract(YEAR FROM dob) AS birth_year, count(*)
FROM students
GROUP BY birth_year;
-- Groups students by birth year and counts the number of students in each year
```

---

### **29. Foreign Key Constraints and `ON DELETE` Actions**

#### 🔸 Table Creation:

- **Using `"user"` as a table name (quoted because it's a reserved keyword):**

```sql
CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    userName VARCHAR(25) NOT NULL
);
```

---

#### 🔸 `ON DELETE` Actions in Foreign Keys

- **`ON DELETE CASCADE`**- Automatically deletes related posts when a user is deleted.

```sql
CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user"(id) ON DELETE CASCADE
    --so user_id is the foreign key of the 'post' table
);
```

- **`ON DELETE SET NULL`** - Sets `user_id` to `NULL` in posts when the related user is deleted.

```sql
CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user"(id) ON DELETE SET NULL
);
```

- **`ON DELETE SET DEFAULT`** - Sets `user_id` to a default value (e.g., 2) when the user is deleted.

```sql
CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER DEFAULT 2 REFERENCES "user"(id) ON DELETE SET DEFAULT
);
```

---

#### 🔸 Sample Data Insertion

- **Insert users:**

```sql
INSERT INTO "user" (userName)
VALUES
    ('ayesha'),
    ('fatima'),
    ('khadiza'),
    ('maryam');
```

- **View users:**

```sql
SELECT * FROM "user";
```

- **Insert posts:**

```sql
INSERT INTO post (title, user_id)
VALUES
    ('My first post!', 1),
    ('Just another update!', 2),
    ('Learning SQL is fun!', 3),
    ('Post number four!', 4),
    ('Quick post for practice.', 2);
```

- **Insert post with NULL user_id (only if `user_id` allows NULLs):**

```sql
INSERT INTO post (title, user_id) VALUES ('test', NULL);
```

- **View posts:**

```sql
SELECT * FROM post;
```

- **Make column non-nullable (if needed):**

```sql
ALTER TABLE post ALTER COLUMN user_id SET NOT NULL;
```

---

#### 🔸 Clean-Up (Optional for Reset)

```sql
DROP TABLE post;
DROP TABLE "user";
```

---

#### 🔸 Deletion Constraints

- **Attempt to delete a user:**

```sql
DELETE FROM "user" WHERE id = 4;
```

> 📝 If `ON DELETE` action is not set (default behavior is `RESTRICT` or `NO ACTION`), deletion will fail if related records exist in the referencing table.

[🔼 Back to Table of Contents](#table-of-contents)

### **30. Joins in PostgreSQL**

#### 🔸 Tables Setup

```sql
CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    userName VARCHAR(25) NOT NULL
);

CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    user_id INTEGER REFERENCES "user" (id)
);
```

#### 🔸 Insert Sample Data

```sql
INSERT INTO "user" (userName)
VALUES ('ayesha'), ('fatima'), ('khadija'), ('maryam');

INSERT INTO post (title, user_id)
VALUES
    ('My first post!', 2),
    ('Just another update!', 1),
    ('Learning SQL is fun!', 1),
    ('Post number four!', 4),
    ('Quick post for practice.', 2),
    ('this is test post title', NULL);
```

---

#### 🔸 `INNER JOIN`- Join only matching rows from both tables, filters out the unrelated posts and users, only show the data which meet condition.

```sql
SELECT title, userName
FROM post
JOIN "user" ON post.user_id = "user".id;

-- View all columns as a single table
SELECT * FROM post JOIN "user" ON post.user_id = "user".id;

-- Column disambiguation(providing context when column names are same, e.g., id)
SELECT "user".id, post.id FROM post JOIN "user" ON post.user_id = "user".id;

-- Using aliases
SELECT p.id FROM post p JOIN "user" u ON p.user_id = u.id;

SELECT p.id FROM post AS p JOIN "user" AS u ON p.user_id = u.id; --using 'as'
```

---

#### 🔸 `LEFT JOIN` - Returns all rows from the `post` table and matched rows from `user`:

```sql
SELECT * FROM post AS p LEFT JOIN "user" u ON p.user_id = u.id;
```

---

#### 🔸 `RIGHT JOIN` - Returns all rows from the `user` table and matched rows from `post`:

```sql
SELECT * FROM post AS p RIGHT JOIN "user" u ON p.user_id = u.id;
```

> ⚠️ Table order matters in `LEFT` and `RIGHT` joins.

---

#### 🔸 `FULL OUTER JOIN`

- Returns all rows from both tables, matched where possible:

```sql
SELECT * FROM post AS p FULL OUTER JOIN "user" u ON p.user_id = u.id;
```

[🔼 Back to Table of Contents](#table-of-contents)

### **31. Additional Join Examples**

##### Sample Tables

```sql
CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_id INT
);

CREATE TABLE department (
    dept_id INT,
    dept_name VARCHAR(50)
);
```

##### Sample Data

```sql
INSERT INTO employees VALUES (1, 'John Doe', 101);
INSERT INTO employees VALUES (2, 'Jane Smith', 102);

INSERT INTO department VALUES (101, 'Human Resources');
INSERT INTO department VALUES (102, 'Marketing');
```

##### `CROSS JOIN`- Combines every row of `employees` with every row of `department`:

```sql
SELECT * FROM employees CROSS JOIN department;
```

##### `NATURAL JOIN`- Joins tables using columns with the same names:

```sql
SELECT * FROM employees NATURAL JOIN department;
-- Requires both tables to have a common column name (e.g., dept_id)
```

[🔼 Back to Table of Contents](#table-of-contents)
