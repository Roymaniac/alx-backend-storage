-- Create Table users

-- The SQL script below creates the table users with the specified attributes and requirements.

CREATE TABLE IF NOT EXISTS users(
    id INTEGER  PRIMARY KEY NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);
