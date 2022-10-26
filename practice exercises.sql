/*
0:15:08 Creating the Databases for this Course 
0:23:40 The SELECT Statement
0:29:30 The SELECT Clause
0:38:18 The WHERE Clause
0:43:35 The AND, OR, and NOT Operators 
0:51:38 The IN Operator
0:54:41 The BETWEEN Operator
0:56:53 The LIKE Operator
1:02:31 The REGEXP Operator
1:11:51 The IS NULL Operator
1:14:18 The ORDER BY Operator
1:21:23 The LIMIT Operator
1:24:50 Inner Joins
1:33:16 Joining Across Databases
1:36:03 Self Joins
1:40:17 Joining Multiple Tables
1:47:03 Compound Join Conditions
1:50:44 Implicit Join Syntax
1:53:04 Outer Joins
1:59:31 Outer Join Between Multiple Tables 
2:05:50 Self Outer Joins
2:08:02 The USING Clause
2:13:25 Natural Joins
2:14:46 Cross Joins
2:18:01 Unions
2:26:29 Column Attributes
2:29:54 Inserting a Single Row 
2:35:40 Inserting Multiple Rows 
2:38:58 Inserting Hierarchical Rows 
2:44:51 Creating a Copy of a Table 
2:53:38 Updating a Single Row 
2:57:33 Updating Multiple Rows 
3:00:47 Using Subqueries in Updates 
3:06:24 Deleting Rows
3:07:48 Restoring Course Databases
*/


SELECT DISTINCT state
 FROM sql_store.customers;
 
 SELECT * FROM sql_store.customers
WHERE state <> 'VA';

SELECT * FROM sql_store.customers
WHERE state != 'VA';

SELECT * FROM customers
WHERE points BETWEEN 1000 AND 3000;

SELECT * FROM customers
WHERE last_name LIKE 'b%';

SELECT * FROM customers
WHERE last_name LIKE '%b%';

SELECT * FROM customers
WHERE last_name LIKE '_____Y';

SELECT * FROM customers
WHERE last_name REGEXP '_____Y';

SELECT * FROM customers
WHERE last_name REGEXP '^Rose';

SELECT * FROM customers
WHERE last_name REGEXP 'dell$';

SELECT * FROM customers
WHERE last_name REGEXP 'Rose|ley';

SELECT * FROM customers
WHERE last_name REGEXP '[gim]e';

SELECT * FROM customers
WHERE last_name REGEXP 'w[son]';

SELECT * FROM customers
WHERE last_name REGEXP '[g-q]';

USE sql_store;
SELECT * FROM customers
WHERE phone IS NOT NULL;

USE sql_hr;
SELECT * FROM employees e
JOIN employees m
ON e.reports_to = m.employee_id;

SELECT 
e.employee_id,
e.first_name,
m.first_name 
FROM employees e
JOIN employees m
ON e.reports_to = m.employee_id;

SELECT 
e.employee_id,
e.first_name,
m.first_name AS manager
FROM employees e
JOIN employees m
ON e.reports_to = m.employee_id;

USE sql_store;
SELECT 
o.order_id,
o.order_date,
c.first_name,
c.last_name,
os.name AS status
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_statuses os
ON o.status = os.order_status_id;

USE sql_invoicing;
SELECT 
p.client_id,
pm.name AS pay_type,
cl.name 
FROM payments p
JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id
JOIN clients cl
ON cl.client_id = p.client_id;

USE sql_store;
SELECT 
pr.product_id,
pr.name,
oi.quantity
FROM products pr
LEFT JOIN order_items oi
ON pr.product_id = oi.product_id
ORDER BY pr.product_id;

USE sql_store;
SELECT 
o.order_id,
c.first_name,
c.customer_id,
sh.name AS shipper
FROM customers c
LEFT JOIN orders o
ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;

USE sql_store;
SELECT 
o.order_date,
o.order_id,
sh.name AS shipper,
os.name AS status,
c.first_name
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
ON o.status = os.order_status_id
ORDER BY o.order_id;

USE sql_store;
SELECT *
FROM order_items oi
LEFT JOIN order_item_notes oin
USING (order_id, product_id);
/*LEFT JOIN shippers sh
ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
ON o.status = os.order_status_id
ORDER BY o.order_id;*/

USE sql_invoicing;
SELECT p.date,
 c.name AS client,
 p.amount,
 pm.name
FROM payments p
JOIN clients c
USING (client_id)
JOIN payment_methods pm
On pm.payment_method_id = p.payment_method;

SELECT p.date,
c.name AS client,
p.amount
FROM payments p
NATURAL JOIN clients c;

SELECT c.first_name AS customer,
p.name AS product 
FROM sql_store.customers c
CROSS JOIN sql_store.products p
ORDER BY c.first_name;

SELECT * 
FROM shippers
CROSS JOIN products
ORDER BY shipper_id;

SELECT * 
FROM shippers, products
ORDER BY shipper_id;

SELECT order_id, order_date,
'Active' AS STATUS
FROM orders 
WHERE order_date >= '2019-01-01'
UNION
SELECT order_id, order_date,
'Archived' AS STATUS
FROM orders 
WHERE order_date < '2019-01-01';

SELECT first_name
FROM customers
UNION
SELECT name
FROM shippers;

SELECT customer_id, first_name, points,
'gold' AS type
FROM customers
WHERE points > 3000
UNION
SELECT  customer_id, first_name, points,
'silver' AS type
FROM customers
WHERE 2000 < points <3000    
UNION
SELECT customer_id, first_name, points,
'bronze' AS type
FROM customers
WHERE points <2000
ORDER BY first_name;


SELECT customer_id, first_name, points,
'gold' AS type
FROM customers
WHERE points > 3000 
UNION 
SELECT customer_id, first_name, points,
'silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000    
UNION
SELECT customer_id, first_name, points,
'bronze' AS type
FROM customers
WHERE points <2000
ORDER BY first_name;

INSERT INTO customers
VALUES (DEFAULT, 
'John', 
'Smith',
'1990-01-01',
NULL,
'address',
'city',
'CA',
DEFAULT);

INSERT INTO customers
(first_name,
last_name,
birth_date,
address,
city,
state,
points)
VALUES (
'Smith',
'John',
'1990-01-01',
'address',
'city',
'CA',
DEFAULT);

INSERT INTO shippers (name)
VALUES ("shippers 1"),
("shippers 2"),
("shippers 3");

INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES ("Mickey", "110", "20.5"),
("Maseeng", "100", "30"),
("Jeanette", "200", "12.5");

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

SELECT LAST_INSERT_ID ();


INSERT INTO order_items
VALUES 
	(LAST_INSERT_ID (), 1, 1, 2.95),
    (LAST_INSERT_ID (), 2, 1, 3.95);
    
CREATE TABLE orders_archived AS
SELECT * FROM orders;

INSERT INTO orders_archived
SELECT * FROM orders
WHERE order_date < '2019-01-01';

USE sql_invoicing;
CREATE TABLE invoices_archived AS
SELECT i.invoice_id,
 i.number,
 c.name AS client,
 i.invoice_total,
 i.payment_total,
 i.invoice_date,
 i.payment_date,
 i.due_date
FROM invoices i
JOIN clients c
USING (client_id)
WHERE payment_date IS NOT NULL;

SELECT * FROM customers
LIMIT 6, 3;

UPDATE invoices
SET payment_total = 10, payment_date = '2019-03-01'
WHERE invoice_id = 1;

UPDATE invoices
SET payment_total = DEFAULT, payment_date = NULL
WHERE invoice_id = 1;

UPDATE invoices
SET payment_total = invoice_total / 2, payment_date = due_date
WHERE invoice_id = 3;

UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE client_id = 3;

UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE client_id IN (3, 4);

USE sql_store;
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

USE sql_invoicing;
UPDATE invoices
SET payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id = (SELECT client_id
                   FROM clients
                   WHERE name = ('Myworks'));
 
 
UPDATE invoices
SET payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id IN (SELECT client_id
                   FROM clients
                   WHERE state IN ('CA','NY'));
 
UPDATE invoices
SET payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE payment_date is NULL;

USE sql_store;
CREATE TABLE orders_updated AS
SELECT
 o.comments,
 cu.points
FROM customers cu
JOIN orders o
USING (customer_id);
UPDATE orders_updated
SET comments = 'gold_standard'
WHERE points >3000;

USE sql_store;
CREATE TABLE orders_updated AS
SELECT
 o.comments,
 cu.points
FROM customers cu
JOIN orders o
USING (customer_id);

UPDATE orders
SET comments = 'gold_standard'
WHERE customer_id IN 
				  (SELECT customer_id
                  FROM customers
                  WHERE points >3000);
                  
DELETE FROM invoices
WHERE invoice_id = 1;

(SELECT * FROM clients
WHERE name = 'MyWorks');

          
                   


