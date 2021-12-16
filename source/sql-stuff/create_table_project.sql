
#Create database:
CREATE DATABASE elinkauppa;

#connect to database:
\connect elinkauppa


#create user table and insert data:

CREATE TABLE tuote (
    id SERIAL NOT NULL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_description VARCHAR(255) NOT NULL,
    product_price VARCHAR(255)
);

CREATE TABLE varasto (
    product_amount INTEGER,
    product_id INTEGER REFERENCES tuote (id) NOT NULL
);

CREATE TABLE ostoskori (
    bucket_id INTEGER,
    product_amount INTEGER,
    product_price VARCHAR(255),
    product_id INTEGER REFERENCES tuote (id) NOT NULL
);

