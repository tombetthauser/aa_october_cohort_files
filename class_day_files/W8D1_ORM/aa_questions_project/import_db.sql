CREATE TABLE users (
  -- column1 datatype
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
)

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title  TEXT NOT NULL,
  body TEXT
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
)