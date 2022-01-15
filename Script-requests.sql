-- ������� ��� ������� (��������������) ������� � �������������� �����������.
-- ������� ��� ������� ������� � �������������� ����������� JOIN � ��� ������������� �����������.

/*
 * �������  ��������� ����� � ������ (jacket id=16), � ��� �� ��� � ������� ������������ ��� �����������.
 */

SELECT 
  CONCAT(
    (SELECT users.firstname FROM users WHERE users.id = reviews_product.user_id),
    ' ',
    (SELECT users.lastname FROM users WHERE users.id = reviews_product.user_id)
         ) AS user_name,
   reviews_product.body,
   reviews_product.created_at
FROM reviews_product
  WHERE reviews_product.product_id = (SELECT products.id FROM products WHERE products.name_product = 'jacket')
  ORDER BY reviews_product.created_at DESC
LIMIT 1;


SELECT 
    CONCAT(users.firstname,' ',users.lastname) AS user_name,
    reviews_product.body,
    reviews_product.created_at 
FROM products
    JOIN reviews_product ON reviews_product.product_id = products.id
    JOIN users ON users.id = reviews_product.user_id 
 WHERE products.name_product = 'jacket'
 ORDER BY reviews_product.created_at DESC
LIMIT 1;


/*
 * ����� ����������� ������������� �������� "adidas" � �������� ������������� ���������.
 */

SELECT 
  (SELECT users.firstname FROM users WHERE users.id IN (
     SELECT orders.user_id FROM orders WHERE orders.order_product_id IN (
       SELECT orders_product.product_id FROM orders_product WHERE products.id = orders_product.product_id) ) ),
products.name_product    
FROM products
WHERE products.brand_id IN (SELECT brand_names.id FROM brand_names WHERE brand_names."name" = 'adidas') 
;


SELECT 
   CONCAT(us.firstname,' ',us.lastname) AS user_name,
     p.name_product 
FROM brand_names bn 
   JOIN products AS p ON p.brand_id = bn.id
   JOIN orders_product op ON op.product_id = p.id
   JOIN orders o ON o.order_product_id = op.id
   JOIN users AS us ON us.id = o.user_id 
 WHERE bn."name" = 'adidas';


/*
 * id = 1 T-shirt /2 orders_product.id = 79 & 76 
 * id = 2 sneakers /2 orders_product.id = 5 & 47
 * id = 27 shorts /1 orders_product.id = 77
 * id = 49 topic /0
 */



--������� ��� �������������, � ������ ������� ����� ������� �������.

--������� ��� ������������� �� ����������� �� ����� �������

CREATE VIEW users_who_have_not_made_purchases AS
SELECT 
   CONCAT(users.firstname,' ',users.lastname) AS user_name
 FROM users
   LEFT JOIN orders 
     ON orders.user_id = users.id 
 WHERE orders.user_id IS NULL;

--������� ��� ������������� ����������� � ����� country 'SouthCarolina'

CREATE VIEW users_residing_SouthCarolina AS
SELECT 
    CONCAT(users.firstname,' ',users.lastname) AS user_name
  FROM addresses
    JOIN users 
      ON addresses.user_id = users.id    
  WHERE country = 'SouthCarolina';

 
--������� ���������������� �������.
 
-- ������� ��������� (������� � ����� ����������) �� ������ �� id ������
 
CREATE FUNCTION quantity_of_goods_in_stock(id_brand INTEGER, OUT count_product BIGINT, OUT sum_product BIGINT) AS
$$
SELECT 
COUNT(products.name_product),
sum(number_products.quantity)
FROM products
JOIN number_products ON products.id = number_products.product_id
JOIN brand_names ON products.brand_id = brand_names.id
WHERE products.brand_id = id_brand
$$
LANGUAGE SQL;


SELECT quantity_of_goods_in_stock(1);
 
--������� �������.


/*
 * ������� �������� ������ ������ ������
 */


DROP FUNCTION check_discount_started_trigger cascade;

CREATE OR REPLACE FUNCTION check_discount_started_trigger() 
RETURNS TRIGGER AS 
$$
BEGIN
	IF NEW.started_at < CLOCK_TIMESTAMP() THEN 
	  RAISE EXCEPTION 'A spoon is the way to dinner. Set the current date.';
   END IF;
  RETURN NEW;
END
$$ 
LANGUAGE PLPGSQL;

CREATE TRIGGER check_discount_started BEFORE INSERT ON discounts
FOR EACH ROW 
EXECUTE FUNCTION check_discount_started_trigger();


INSERT INTO discounts (id, user_id, product_id, discount, started_at, finished_at)
VALUES (101,26,65,20,'1993-04-10 12:53:15','1993-06-09 08:44:44');

INSERT INTO discounts (id, user_id, product_id, discount, started_at, finished_at)
VALUES (101,26,65,20,'2022-02-24 12:53:15','2022-03-24 12:53:15');











