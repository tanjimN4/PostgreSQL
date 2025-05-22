-- Handling Date and Date Functions in PostgreSQL
select now()

CREATE Table timeZone (ts TIMESTAMP without TIME zone, tsz TIMESTAMP with TIME zone)

INSERT INTO timeZone (ts, tsz) VALUES (NOW(), NOW());

SELECT * FROM timeZone;

select now()::date

select now()::TIME

select CURRENT_DATE

-- Converts time stamp to string according to the given format.
select to_char(now(),'mm/dd/yyyy')

select CURRENT_DATE - INTERVAL '5 day'

select age(CURRENT_DATE,'2000-01-23')

select *,age(CURRENT_DATE,dob) FROM students 

SELECT extract(day from '2024-01-25'::date);

SELECT 'y'::BOOLEAN