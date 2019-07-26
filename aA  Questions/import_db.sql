PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS replies; 
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body VARCHAR(255),
  author_id VARCHAR(255),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE questions_follows (
  id INTEGER PRIMARY KEY,
  user_id INT,
  question_id INT,
  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  q_reply_id INT NOT NULL,
  parent_reply_id INT,
  author_reply_id INT NOT NULL,
  body TEXT NOT NULL, 
  FOREIGN KEY (q_reply_id) REFERENCES questions(id)
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
  FOREIGN KEY (author_reply_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  if_like INT,
  like_user_id INT,
  like_q_id INT,
  FOREIGN KEY (like_user_id) REFERENCES users(id)
  FOREIGN KEY (like_q_id) REFERENCES questions(id)
);

INSERT INTO
  users ( fname, lname)
VALUES
  ( 'Orisa', 'Violin'),
  ( 'Jesus', 'Cruise'),
  ( 'Lunch', 'Time'),
  ( 'Harry', 'Potter')
  ;

INSERT INTO
  questions ( title, body, author_id)
VALUES
  ( 'How to sum', 'I''m having trouble summing how do I sum?', 1),
  ( 'How to divide', 'I''m having trouble dividing how do I use the slash?', 1),
  ( 'What''s for lunch', 'I''m having trouble summing finding lunch where can I find it?', 3),
  ( 'Fav book', 'Do you like Lord of the Rings or Harry Potter better?', 4)
  ;

INSERT INTO
  questions_follows ( user_id, question_id)
VALUES
  ( 1, 3),
  ( 2, 2),
  ( 3, 1),
  ( 4, 4),
  ( 1, 4),
  ( 2, 1);

INSERT INTO
  replies ( q_reply_id, parent_reply_id, author_reply_id, body)
VALUES
  ( 1, NULL, 4, 'Use the + sign'),
  ( 2, NULL, 3, 'Use Fractions'),
  ( 3, NULL, 3, 'Found it'),
  ( 1, 1, 2, 'AGREE!' );

  INSERT INTO
  question_likes ( if_like, like_user_id, like_q_id)
VALUES
  ( 1, 1, 4),
  ( 1, 2, 1),
  ( 1, 3, 4),
  ( 1, 4, 3),
  ( 1, 1, 4),
  ( 1, 4, 2),
  ( 1, 4, 1)
  ;