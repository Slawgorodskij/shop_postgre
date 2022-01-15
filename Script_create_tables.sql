
/* ���� ���������� (��������) */
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	url VARCHAR(250) NOT NULL UNIQUE,
	filename VARCHAR(250) NOT NULL UNIQUE,
 	metadata JSON	
);

/* ������ gender*/
CREATE TYPE gender_t AS ENUM (male, female);

/* ������� �������������*/
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL, 
    lastname VARCHAR(50)NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    gender gender_t,
    password VARCHAR(100),
    photo_user INT,
    created_at TIMESTAMP DEFAULT NOW(),
    
    FOREIGN KEY (photo_user) REFERENCES media(id)    
);

CREATE INDEX users_firstname_lastname_idx ON users (firstname,lastname);

/*������� � ������� ��������*/
CREATE TABLE addresses(
	id SERIAL PRIMARY KEY,
	user_id INT,
	country VARCHAR(50),
	city VARCHAR(50),
	street VARCHAR(50),
	home VARCHAR(50),

	FOREIGN KEY (user_id) REFERENCES users(id)
);

/*������� � ������������� �������� �������*/
CREATE TABLE brand_names(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL
);

/*������� ��������� ������*/
CREATE TABLE categories(
	id SERIAL PRIMARY KEY,
	category VARCHAR(150) NOT NULL
);

/* ������� ������*/
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name_product VARCHAR(255),
    brand_id INT,
    category_id INT,
    description TEXT,
    price INT, 
    
    FOREIGN KEY (brand_id) REFERENCES brand_names(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

/*������� �������� ������*/
CREATE TABLE product_sizes(
	id SERIAL PRIMARY KEY,
	sizes CHAR (14) NOT NULL
);

/*������� ������*/
CREATE TABLE colors(
	id SERIAL PRIMARY KEY,
	color CHAR (30) NOT NULL
);

/*������� ���������� ������*/
CREATE TABLE number_products(
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  color_id INT NOT NULL,
  size_id INT,
  quantity INT  DEFAULT 0,
  
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (color_id) REFERENCES colors(id),
  FOREIGN KEY (size_id) REFERENCES product_sizes(id) 
);

/*������� ���������� (��������) ������*/
CREATE TABLE photo_products(
	id SERIAL,
    media_id INT NOT NULL,
    product_id INT NOT NULL,
	color_id INT,
 	
 	FOREIGN KEY (media_id) REFERENCES media(id),
	FOREIGN KEY (product_id) REFERENCES products(id),
 	FOREIGN KEY (color_id) REFERENCES colors(id)
);

/*������� ����������� ��������*/
CREATE TABLE orders_product(
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  color_id INT,
  size_id INT,
  total INT DEFAULT 1,
  
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (color_id) REFERENCES colors(id),
  FOREIGN KEY (size_id) REFERENCES product_sizes(id) 
);

/*������� ������*/
CREATE TABLE orders(
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  order_product_id INT NOT NULL,
  address_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (address_id) REFERENCES addresses(id),
  FOREIGN KEY (order_product_id) REFERENCES orders_product(id) 
);

/*������� ������� � ��������*/
CREATE TABLE reviews_shop(
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  body TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
 
  FOREIGN KEY (user_id) REFERENCES users(id) 
);

/*������� ������� � ������*/
CREATE TABLE reviews_product(
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  product_id INT NOT NULL,
  body TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
   
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id) 
);

/*������� ������*/
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT,
  product_id INT,
  discount INT,
  started_at TIMESTAMP NOT NULL,
  finished_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
