CREATE DATABASE user_management;
CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       username TEXT UNIQUE NOT NULL,
                       password TEXT NOT NULL,
                       role TEXT NOT NULL CHECK (role IN ('Employee', 'Manager', 'Admin'))
);

CREATE TABLE software (
                          id SERIAL PRIMARY KEY,
                          name TEXT NOT NULL,
                          description TEXT,
                          access_levels TEXT CHECK (access_levels IN ('Read', 'Write', 'Admin'))
);

CREATE TABLE requests (
                          id SERIAL PRIMARY KEY,
                          user_id INT REFERENCES users(id),
                          software_id INT REFERENCES software(id),
                          access_type TEXT CHECK (access_type IN ('Read', 'Write', 'Admin')),
                          reason TEXT,
                          status TEXT DEFAULT 'Pending' CHECK (status IN ('Pending', 'Approved', 'Rejected'))
);
