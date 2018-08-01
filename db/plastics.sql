DROP TABLE products;
DROP TABLE tags;
DROP TABLE plastics;


CREATE TABLE plastics(
  id SERIAL8 PRIMARY KEY,
  type VARCHAR(255) NOT NULL,
  existence INT4,
  weight INT4 NOT NULL,
  conversion_factor NUMERIC,
  recycable BOOLEAN
);

CREATE TABLE tags(
  id SERIAL8 PRIMARY KEY,
  category VARCHAR(255)
);

CREATE TABLE products(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  avoidability BOOLEAN,
  quantity INT4 NOT NULL,
  time_stamp DATE,
  plastic_id INT8 REFERENCES plastics(id) ON DELETE CASCADE,
  tag_id INT8 REFERENCES tags(id) ON DELETE CASCADE
)
