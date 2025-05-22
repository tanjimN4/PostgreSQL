CREATE Table "user"(
    id SERIAL PRIMARY KEY,
    username VARCHAR(25) NOT NULL
)

CREATE Table post(
    id SERIAL PRIMARY KEY,
    title text NOT NULL,
    user_id INTEGER REFERENCES "user"(id)
)



INSERT INTO "user" (username) VALUES
('akash'),
('batash'),
('sagor'),
('nodi');

INSERT INTO post (title, user_id) VALUES
('Enjoying a sunny day with Akash! ☀️', 2),
('Batash just shared an amazing recipe! 🍲', 1),
('Exploring adventures with Sagor.🌟', 4),
('Nodi''s wisdom always leaves me inspired. 📚', 4);


select * from post;

SELECT * FROM "user"


SELECT title,username,post.id FROM post
JOIN "user" on post.user_id ="user".id

select title,username FROM "user"
JOIN post on "user".id = post.user_id

INSERT INTO post (title, user_id) VALUES ('Enjoying a sunny day', NULL);

SELECT * FROM post
LEFT JOIN "user" on post.user_id ="user".id

SELECT * FROM post
RIGHT JOIN "user" on post.user_id ="user".id

SELECT * FROM post
FULL JOIN "user" on post.user_id ="user".id