-- Connect to database
ALTER ROLE postgres
SET search_path = maven_advanced_sql;

ALTER DATABASE maven_project_db
SET search_path = maven_advanced_sql;

-- ASSIGNMENT 1: Basic Joins
-- Looking at the orders and products tables, which products exist in one table, but not the other?

-- View the orders and products tables
SELECT * FROM orders;
SELECT * FROM products;

SELECT COUNT(DISTINCT product_id) FROM orders;
SELECT COUNT(DISTINCT product_id) FROM products;

-- Join the tables using various join types & note the number of rows in the output
SELECT	COUNT(*)
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id; -- 8549

SELECT	COUNT(*)
FROM	orders o RIGHT JOIN products p
		ON o.product_id = p.product_id; --8552
        
-- View the products that exist in one table, but not the other
SELECT	COUNT(*)
FROM	orders o RIGHT JOIN products p
		ON o.product_id = p.product_id
WHERE	o.product_id IS NULL;

SELECT	COUNT(*)
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id
WHERE	p.product_id IS NULL;

-- Pick a final JOIN type to join products and orders
SELECT	pr.product_id, pr.product_name, ord.product_id AS product_id_in_orders
FROM	products pr
		LEFT JOIN orders ord
		ON pr.product_id = ord.product_id
WHERE	ord.product_id IS NULL;


-- ASSIGNMENT 2: Self Joins
-- Which products are within 25 cents of each other in terms of unit price?

-- View the products table
SELECT * FROM products;

-- Join the products table with itself so each candy is paired with a different candy
SELECT	p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price
FROM	products p1 INNER JOIN products p2
		ON p1.product_id <> p2.product_id

        
-- Calculate the price difference, do a self join, and then return only price differences under 25 cents
SELECT	p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price,
		(p1.unit_price - p2.unit_price) AS price_diff
FROM	products p1 INNER JOIN products p2
		ON p1.product_id <> p2.product_id
WHERE	ABS(p1.unit_price - p2.unit_price) < 0.25
		AND p1.product_name < p2.product_name --- Without duplicate names
ORDER BY
		price_diff DESC;

-- Hay valores duplicados de nombres de productos
SELECT	p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price,
		(p1.unit_price - p2.unit_price) AS price_diff
FROM	products p1 INNER JOIN products p2
		ON p1.product_id <> p2.product_id
WHERE	ABS(p1.unit_price - p2.unit_price) < 0.25
ORDER BY
		price_diff DESC;
--


SELECT	p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price,
		(p1.unit_price - p2.unit_price) AS price_diff
FROM	products p1 INNER JOIN products p2
		ON p1.product_id <> p2.product_id
WHERE	(p1.unit_price - p2.unit_price) BETWEEN (-0.25) AND (0.25)
ORDER BY
		price_diff DESC

