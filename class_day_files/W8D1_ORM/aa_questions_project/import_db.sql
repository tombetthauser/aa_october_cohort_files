PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT, 
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  subject_id INTEGER NOT NULL,
  user_reply_id INTEGER NOT NULL,
  parent_reply_id INTEGER,

  FOREIGN KEY (subject_id) REFERENCES questions(id),
  FOREIGN KEY (user_reply_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  questions_id INTEGER NOT NULL,
  users_id INTEGER NOT NULL,

  FOREIGN KEY (users_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);

INSERT INTO 
  users (fname, lname)
VALUES
  ('Ned', 'Brown'),
  ('Kush', 'Patel'),
  ('Earl', 'Green');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Ned Title', 'gibbberrrrrishhh', (SELECT id FROM users WHERE fname = 'Ned' AND lname ='Brown')),
  ('Kush Title', 'yeahhhh....', (SELECT id FROM users WHERE fname ='Kush' AND lname = 'Patel')),
  ('Earl Title', 'idk', (SELECT id FROM users WHERE fname ='Earl' AND lname = 'Green'));

INSERT INTO
  replies (body, subject_id, user_reply_id, parent_reply_id)
VALUES 
  ('great question', 1, 3, NULL),
  ('terrible question', 2, 3, NULL),
  ('downvoted', 2, 1, NULL),
  ('nah, upvoted', 2, 2, 3);

INSERT INTO
  question_follows (users_id, questions_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 2),
  (1, 3),
  (2, 3);

INSERT INTO
  question_likes (questions_id, users_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 2),
  (1, 3),
  (2, 3);