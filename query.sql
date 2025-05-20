-- Active: 1747740769304@@127.0.0.1@5432@ph
SELECT * FROM person2

ALTER TABLE person2
ADD COLUMN email VARCHAR(25) DEFAULT 'fakedata' NOT NULL

ALTER TABLE person2
DROP COLUMN email

ALTER TABLE person2
RENAME COLUMN age to user_age

ALTER Table person2
alter COLUMN user_name type VARCHAR(50)

alter Table person2 
alter COLUMN user_age set not NULL

alter Table person2 
alter COLUMN user_age DROP not NULL

ALTER TABLE person2
ADD CONSTRAINT unique_person2_user_age UNIQUE (user_age);
ALTER TABLE person2
DROP CONSTRAINT unique_person2_user_age 


TRUNCATE TABLE person2;
DROP TABLE person2;


INSERT into person2 values(3,'masud',19,'masudg@g.com')