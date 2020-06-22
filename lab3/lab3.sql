--1. INSERT
-- 1. ��� �������� ������ �����
INSERT INTO storage VALUES (1, 'Nice storage', 'Russia, Yoshkar-Ola, Kalinina, 3', 3000, 1);
-- 2. � ��������� ������ �����
INSERT INTO product (name, price) VALUES ('fish', 400);
-- 3. � ������� �������� �� ������ �������
INSERT INTO product_in_storage(id_owner) SELECT id_owner FROM owner;

--2. DELETE
-- 1. ���� �������
DELETE FROM factory;
-- 2. �� �������
DELETE FROM product WHERE price > 500;
-- 3. �������� �������
TRUNCATE TABLE owner;

--3. UPDATE
-- 1. ���� �������
UPDATE factory
SET name = 'Progress';
-- 2. �� ������� �������� ���� �������
UPDATE factory
SET phone = '89657439506' WHERE name = 'Color';
-- 3. �� ������� �������� ��������� ���������
UPDATE product_in_storage
SET quantity = 49, id_product = '3' WHERE delivery_date = '2020-05-08';


--4. SELECT
-- 1. � ������������ ������� ����������� ���������
SELECT name, address FROM storage;
-- 2. �� ����� ����������
SELECT * FROM owner;
-- 3. � �������� �� ��������
SELECT * FROM product WHERE name = 'fish';


--5. SELECT ORDER BY + TOP (LIMIT)
-- 1. � ����������� �� ����������� ASC + ����������� ������ ���������� �������
SELECT TOP 5 * FROM factory ORDER BY name ASC;
-- 2. � ����������� �� �������� DESC
SELECT * FROM product ORDER BY price DESC;
-- 3. � ����������� �� ���� ��������� + ����������� ������ ���������� �������
SELECT TOP 4 * FROM owner ORDER BY first_name, last_name DESC;
-- 4.  � ����������� �� ������� ��������, �� ������ �����������
SELECT name, capacity FROM storage ORDER BY 1;


--6. ������ � ������. ����������, ����� ���� �� ������ ��������� ������� � ����� DATETIME.
-- 1. WHERE �� ����
SELECT id_storage FROM product_in_storage WHERE delivery_date = '2019-03-15T00:00:00';
-- 2. ������� �� ������� �� ��� ����, � ������ ���
SELECT YEAR(delivery_date) from product_in_storage;


--7. SELECT GROUP BY � ��������� ���������
-- 1. MIN
SELECT name, MIN(price) AS min_price FROM product GROUP BY name;
-- 2. MAX
SELECT name, MAX(capacity) AS max_capacity FROM storage GROUP BY name;
-- 3. AVG
SELECT name, AVG(price) AS avg_price FROM product GROUP BY name;
-- 4. SUM
SELECT name, SUM(capacity) AS sum_capacity FROM storage GROUP BY name;
-- 5. COUNT
SELECT name, COUNT(price) AS count_price FROM product GROUP BY name;


--8. SELECT GROUP BY + HAVING
-- 1.
SELECT id_product FROM product_in_storage GROUP BY id_product HAVING COUNT(*) < 7;
-- 2.
SELECT name, MIN(price) AS min_price FROM product GROUP BY name HAVING MIN(price) < 400;
-- 3.
SELECT name, MIN(capacity) FROM storage WHERE id_storage < 6 GROUP BY name HAVING MIN(capacity) > 1000;


--9. SELECT JOIN
-- 1. LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
SELECT * FROM product_in_storage LEFT JOIN product ON product_in_storage.id_product = product.id_product WHERE product.price > 50;

-- 2. RIGHT JOIN. �������� ����� �� �������, ��� � � 9.1
SELECT * FROM product RIGHT JOIN product_in_storage ON product_in_storage.id_product = product.id_product WHERE product.price > 50 ORDER BY name ASC;

-- 3. LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
SELECT * FROM product_in_storage LEFT JOIN storage ON product_in_storage.id_storage = storage.id_storage
LEFT JOIN product on product_in_storage.id_product = product.id_product
WHERE product.name = 'fish' and storage.name = 'Seven sea' and product_in_storage.quantity = 40;

-- 4. FULL OUTER JOIN ���� ������
SELECT * FROM product_in_storage FULL OUTER JOIN product ON product_in_storage.id_product = product.id_product


--10. ����������
-- 1. �������� ������ � WHERE IN (���������)
SELECT * FROM product WHERE id_product IN (SELECT id_product FROM product_in_storage);
-- 2. �������� ������ SELECT atr1, atr2, (���������) FROM ...
SELECT name, (SELECT MIN(price) FROM product) FROM product;