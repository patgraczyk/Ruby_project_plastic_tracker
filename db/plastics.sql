DROP TABLE products;
DROP TABLE tags;
DROP TABLE plastics;


CREATE TABLE plastics(
id SERIAL8 primary key,
type VARCHAR(255),
existance INT4,
weight INT4
-- emission_factor INT4, [for extension =weight * qant* emission_factor]
);

CREATE TABLE tags(
id SERIAL8 primary key,
category VARCHAR(255)
);

CREATE TABLE products(
id SERIAL8 primary key,
name VARCHAR(255),
avoidability BOOLEAN,
quantity INT4,
-- date [for extensions]
plastic_id INT8 REFERENCES plastics(id),
tag_id INT8 REFERENCES tags(id)
)
